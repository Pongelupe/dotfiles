# !/bin/bash

# file to be decrypted
file="$1"
expected_ext=age

# Check if file exists and is readable
if [[ ! -f "$file" || ! -r "$file" || ! "$file" =~ \."$expected_ext"$ ]]; then
    echo "Error: File '$file' does not exist or is not readable" >&2
    exit 1  # exit
fi
cat $DOT_FILES/secrets/skeleton_key | age -d > .key.tmp  2> /dev/null

if [ $? -ne 0 ]; then
    echo "Your pick has broken, Dovahkiin!" >&2
    exit 1  # exit
fi
cat $file | age -d -i .key.tmp
rm .key.tmp

