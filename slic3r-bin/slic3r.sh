#!/bin/bash
set -o pipefail
_APPDIR="/usr/lib/@appname@"
export PATH="${_APPDIR}:${PATH:-}"
export LD_LIBRARY_PATH="${_APPDIR}/lib:${LD_LIBRARY_PATH:-}"
cd "${_APPDIR}"
exec "${_APPDIR}/perl-local" -I"${_APPDIR}/local-lib/lib/perl5" "${_APPDIR}/@runname@" "$@" || exit $?