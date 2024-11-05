#!/bin/bash
set -e
_APPDIR="/usr/lib/@appname@"
_RUNNAME="${_APPDIR}/@runname@"
_OPTIONS="@options@"
export PATH="${_APPDIR}:${PATH}"
export LD_LIBRARY_PATH="${_APPDIR}/swiftshader:${_APPDIR}/lib:${LD_LIBRARY_PATH}"
export ELECTRON_IS_DEV=0
export ELECTRON_FORCE_IS_PACKAGED=true
export ELECTRON_DISABLE_SECURITY_WARNINGS=true
export NODE_ENV=production
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
_FLAGS_FILE="${XDG_CONFIG_HOME}/@appname@-flags.conf"
declare -a flags
if [[ -f "${_FLAGS_FILE}" ]]; then
    mapfile -t < "${_FLAGS_FILE}"
fi
for line in "${MAPFILE[@]}"; do
    if [[ ! "${line}" =~ ^[[:space:]]*#.* ]] && [[ -n "${line}" ]]; then
        flags+=("${line}")
    fi
done

WAYLAND_OPTION=false
for arg in "$@"; do
    if [[ "$arg" == "--wayland" ]]; then
        WAYLAND_OPTION=true
        break
    fi
done

if [[ "${WAYLAND_OPTION}" == true ]]; then
    echo "Forcing Wayland"
    flags+=("--enable-features=UseOzonePlatform,WaylandWindowDecorations,VaapiVideoDecodeLinuxGL" "--ozone-platform=wayland")
fi

cd "${_APPDIR}"
if [[ "${EUID}" -ne 0 ]] || [[ "${ELECTRON_RUN_AS_NODE}" ]]; then
    exec electron@electronversion@ "${_RUNNAME}" "${_OPTIONS}" "${flags[@]}" "${_USER_FLAGS}" "$@" || exit $?
else
    exec electron@electronversion@ "${_RUNNAME}" "${_OPTIONS}" --no-sandbox "${flags[@]}" "${_USER_FLAGS}" "$@" || exit $?
fi