#!/bin/sh -l

FORMAT="lcov"
OUTPUT_FILE=./coverage/lcov.info

while :; do
    case $1 in
        -derivedDataPath) DERIVED_DATA_PATH=$2
        shift
        ;;
        -target) TARGET=$2
        shift
        ;;
        -format) FORMAT=$2
        shift
        ;;
        -output) OUTPUT_FILE=$2
        shift
        ;;
        *) break
    esac
    shift
done

if [ -z "$DERIVED_DATA_PATH" ]; then
    echo "Error: missing -derivedDataPath"
    exit 1
fi

if [ -z "$TARGET" ]; then
    echo "Error: missing -target"
    exit 1
fi

TARGET_PATH=$(find ${DERIVED_DATA_PATH} -name "${TARGET}")
INSTR_PROFILE=$(find ${DERIVED_DATA_PATH} -name "*.profdata")
IGNORE_FILENAME_REGEX="SourcePackages|Pods|Carthage"

filename=$(basename "$TARGET_PATH")
COV_BIN="${TARGET_PATH}/${filename%.*}"
PATH="/usr/local/opt/llvm/bin:$PATH"

mkdir -p $(dirname "$OUTPUT_FILE")

llvm-cov report \
    "${COV_BIN}" \
    -instr-profile=$INSTR_PROFILE \
    -ignore-filename-regex=$IGNORE_FILENAME_REGEX \
    -use-color

llvm-cov export \
    "${COV_BIN}" \
    -instr-profile=$INSTR_PROFILE \
    -ignore-filename-regex=$IGNORE_FILENAME_REGEX \
    -format=$FORMAT > $OUTPUT_FILE