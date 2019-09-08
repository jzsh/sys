#!/bin/sh

msg () {
	local type="$1"
	shift 1
	local message="$*"
	local param="-e"
	case $type in
	error)
		echo $param "\033[31m$message \033[0m"
		;;
	info)
		echo $param "\033[34m$message \033[0m"
		;;
	warn)
		echo $param "\033[34m$message \033[0m"
		;;
	esac
}

log_info() {
	msg info "$1"
}

log_error() {
	msg error "$1"
}

log_warn() {
	msg warn "$1"
}



