# !/bin/bash

# file to be encrypted
file="$1"

# Check if file exists and is readable
if [[ ! -f "$file" || ! -r "$file" ]]; then
    echo "Error: File '$file' does not exist or is not readable" >&2
    exit 1  # exit
fi

if  key=$(cat ~/workspace/dotfiles/secrets/skeleton_key | age -d 2>/dev/null); then
    key=$(echo $key |  awk '{print $7}')
    echo "Creating $file.age"
    age -r $key $file > $file.age
else
    echo "Error: Your pick has broken, Dovahkiin!" >&2
    exit 1  # exit
fi


