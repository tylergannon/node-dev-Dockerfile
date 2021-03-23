#!/bin/sh
export PATH=${PATH}:/code/script

SHA_FILE="node_modules/package.json.sha256sum"

sha256sum -s -c ${SHA_FILE} 2> /dev/null
RESULT=$?
if [ "${RESULT}" != "0" ]; then
    echo "Installing packages."
    pnpm install -s
    sha256sum package.json > ${SHA_FILE}
    cat ${SHA_FILE}
fi

