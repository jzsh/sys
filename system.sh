#!/bin/bash

# WSL Ubuntu 装机/恢复脚本
# 目的：重装系统后快速恢复常用开发环境和配置
# 说明：在非 root 用户下执行，只有需要写系统配置或安装软件时才使用 sudo。
set -euo pipefail

if [ "$(id -u)" -eq 0 ]; then
    echo "Do not run as root"
    exit 1
fi

msg() {
    local type="$1"
    shift
    local message="$*"
    case "$type" in
    error)
        printf '\033[31m%s\033[0m\n' "$message"
        ;;
    info)
        printf '\033[34m%s\033[0m\n' "$message"
        ;;
    *)
        printf '%s\n' "$message"
        ;;
    esac
}

show_help() {
    cat <<'EOF'
Usage: system.sh [command]

Available commands:
  help          Show this help message
  update        Update apt source to Aliyun and upgrade system
  install       Install common packages
  configure_wsl Configure /etc/wsl.conf for WSL
  keygen        Generate SSH key if missing
  clone         Clone repositories and run personal setup
  gitconfig     Apply local git configuration
  full          Run full recovery flow

If no command is provided, the script prints this help message.
EOF
}

update_aliyun_sources() {
    local release
    release=$(lsb_release -cs 2>/dev/null || awk -F'=' '/^VERSION_CODENAME=/ {print $2}' /etc/os-release 2>/dev/null)
    if [ -z "$release" ]; then
        msg error "无法识别 Ubuntu 发行版代号。"
        return 1
    fi

    if grep -q 'mirrors.aliyun.com' /etc/apt/sources.list 2>/dev/null; then
        msg info "已配置 Aliyun apt 源。"
        return 0
    fi

    msg info "备份原始 apt 源到 /etc/apt/sources.list.bak"
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
    sudo tee /etc/apt/sources.list > /dev/null <<EOF
# 阿里云 Ubuntu 源
deb http://mirrors.aliyun.com/ubuntu/ $release main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ $release-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ $release-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ $release-backports main restricted universe multiverse
EOF
    msg info "已切换到 Aliyun apt 源。"
}

update() {
    msg info "开始系统升级..."
    update_aliyun_sources
    sudo apt-get update -y
    sudo apt-get upgrade -y
}

install() {
    local pkgs="git vim expect openssh-server build-essential tig exuberant-ctags neovim python3 python3-pip python3-venv nodejs npm tmux htop unzip zip ripgrep silversearcher-ag fzf fd-find lsb-release ca-certificates gnupg software-properties-common gpg-agent"
    local installed

    installed=$(dpkg -l | awk '/^ii/ {print $2}')
    for pkg in $pkgs; do
        if ! printf '%s\n' "$installed" | grep -qx "$pkg"; then
            msg info "安装 $pkg"
            sudo apt-get -y install "$pkg"
        fi
    done
}

configure_wsl() {
    local conf=/etc/wsl.conf
    if [ ! -f "$conf" ] || ! grep -q '^\[automount\]' "$conf" 2>/dev/null; then
        msg info "配置 WSL /etc/wsl.conf"
        sudo tee -a "$conf" > /dev/null <<'EOF'
[automount]
enabled = true
options = "metadata,umask=22,fmask=11"
mountFsTab = false

[interop]
enabled = true
appendWindowsPath = true
EOF
    else
        msg info "/etc/wsl.conf 已存在，保留原有配置。"
    fi
}

keygen() {
    if [ -e ~/.ssh/id_rsa.pub ]; then
        msg info "SSH 密钥已存在。"
        return
    fi

    expect <<'EOF'
spawn ssh-keygen -t rsa -C "guojiangzhe@hotmail.com"
expect "Enter file in which to save the key"
send "\n"
expect "Enter passphrase"
send "\n"
expect "Enter same passphrase again"
send "\n"
expect eof
EOF
}

clone() {
    local rep="sys snip"
    for r in $rep; do
        if [ ! -d "$HOME/git_home/${r}.git" ]; then
            git clone "https://jzsh@github.com/jzsh/${r}.git" "$HOME/git_home/${r}.git"
        fi
    done

	vimdir="$HOME/git_home/sys.git/vim"
    if [ -d "$vimdir" ]; then
		msg info "运行 vim 相关的个人配置脚本"
        cd "$vimdir"
        sh "$vimdir/genln"
        cd - >/dev/null
    fi
}

gitconfig() {
    if [ -f "$(pwd)/git/gitconfig" ]; then
		msg info "应用本地 git 配置"
        bash "$(pwd)/git/gitconfig"
    fi
}

full() {
    update
    install
    configure_wsl
    clone
    gitconfig
    keygen
}

if [ $# -eq 0 ]; then
    show_help
else
    while [ $# -gt 0 ]; do
        case "$1" in
            help|-h|--help)
                show_help
                ;;
            update|install|configure_wsl|keygen|clone|gitconfig|full)
                "$1"
                ;;
            *)
                msg error "未知命令: $1"
                show_help
                exit 1
                ;;
        esac
        shift
    done
fi
	





