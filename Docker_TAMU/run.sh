#!/bin/sh

. $(dirname "$0")/utils.sh

modes=0
if [ $# -ne 0 ]; then
    if [ $(echo "-help" | grep -Eo "^$1$") ] ||
        [ $(echo "-vnc" | grep -Eo "^$1$") ] ||
        [ $(echo "-shell" | grep -Eo "^$1$") ] ||
        [ $(echo "-browser" | grep -Eo "^$1$") ] ||
        [ $(echo "-batch" | grep -Eo "^$1$") ]; then
        CUSTOM=false
    else
        CUSTOM=true
    fi
fi

if [ "$CUSTOM" = false ]; then
    while [ $# -gt 0 ]; do
        case "$1" in
        -help)
            HELP=true
            modes=$((modes + 1))
            ;;
        -vnc)
            VNC=true
            modes=$((modes + 1))
            ;;
        -shell)
            SHELL=true
            modes=$((modes + 1))
            ;;
        -browser)
            BROWSER=true;
            modes=$((modes+1))
            ;;
        -batch)
            BATCH=true
            BATCH_COMMAND=$(build_cmd "$2")
            modes=$((modes + 1))
            ;;
        esac
        shift
    done
else
    CUSTOM_COMMAND=$(build_cmds "$@")
fi

validateInput
#checkLicensing
checkSharedMemorySpace
checkEnvironmentVariables
startContainer

exit
