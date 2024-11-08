#!/bin/bash

if [[ $# -lt 3 ]]; then
	echo "$0: size input_file_name output_file_name"
	exit 255
fi

SIZE="$1"
INPUT_FILE_NAME="$2"
OUTPUT_FILE_NAME="$3"
CHOPPED_FILE_CONTENT="$(head --lines=36 "$INPUT_FILE_NAME")"

if TMP_FILE="$(mktemp --tmpdir tumbler-text-XXXXXX)"; then
	convert -size 210x254 \
		-background "#fffaed" \
		-fill black \
		-border 1x1 -bordercolor "#00aaff" \
		-font "Liberation-Mono" -pointsize 5 \
		label:"$CHOPPED_FILE_CONTENT" "$TMP_FILE"

	if [[ $SIZE -lt 256 ]]; then
		convert -thumbnail "${SIZE}x${SIZE}" -define png:compression-level=3 \
			"$TMP_FILE" "$OUTPUT_FILE_NAME"
	else
		cat "$TMP_FILE" > "$OUTPUT_FILE_NAME"
	fi

	rm "$TMP_FILE"
	exit 0
else
	exit 1
fi
