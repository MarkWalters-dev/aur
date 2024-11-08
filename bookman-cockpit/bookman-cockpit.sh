#!/bin/sh

set -eu

export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
home="${XDG_CONFIG_HOME:-"$HOME/.config"}/bookman-cockpit"
if ! jfx_libs="$(readlink -f /usr/lib/jvm/java-21*-openjfx/lib)"
then
    jfx_libs="$JAVA_HOME/lib"
fi

"${JAVA_HOME}/bin/java" \
    -Duser.home="$home" \
    -Dde.bookman.deployMode=LIVE \
    -Dde.bookman.javaBackendUri=https://cockpit.bookman-gmbh.de/api/java/ \
    -Dde.bookman.microsoftApplicationId=a7719d9a-1877-4bd1-a3c7-e3f8edf86485 \
    -Dde.bookman.microsoftSsoRedirectUrl=http://localhost:4826 \
    -cp "/opt/bookman-cockpit/override/:${jfx_libs}/*:/opt/bookman-cockpit/jars/*" \
    de.bookman.start.MainGradle

