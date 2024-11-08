#!/bin/bash
set -o pipefail
_APPDIR="/usr/lib/@appname@"
_RUNNAME="${_APPDIR}/@runname@"
export PATH="${_APPDIR}:${_APPDIR}/main/runtimes/17.0.6/jre/bin:${PATH:-}"
export LD_LIBRARY_PATH="${_APPDIR}/main/0.7.5:${_APPDIR}/main/runtimes/17.0.6/jre/lib:${LD_LIBRARY_PATH:-}"
cd "${_APPDIR}" || { echo "Failed to change directory to ${_APPDIR}"; exit 1; }
exec "${_RUNNAME}" "$@" || exit $?