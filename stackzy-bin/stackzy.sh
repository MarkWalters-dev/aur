#!/bin/bash
set -o pipefail
_APPDIR=/usr/lib/@appname@
_RUNNAME="${_APPDIR}/bin/@runname@"
export PATH="${_APPDIR}/bin:${PATH}"
export LD_LIBRARY_PATH="${_APPDIR}/lib:${_APPDIR}/lib/runtime/lib:${LD_LIBRARY_PATH}"
cd "${_APPDIR}"
exec "${_RUNAPP}" "$@" || exit $?