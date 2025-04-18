# !/bin/bash

echo "Executing a lockpick test..."
cd $DOT_FILES/secrets
cat skeleton_key | age -d > .key.tmp  2> /dev/null

if [ $? -ne 0 ]; then
    echo "Your pick has broken, Dovahkiin!" >&2
    exit 1  # exit
fi

echo "Chest opened!"

echo "Using skeleton key to unlock all chests"

for file in $(find . -type f -name "*.age"); do
    echo "Processing: $file"
    name="${file%.*}"
    cat $file | age -d -i .key.tmp > $name
    echo "Created: $name"
done

cat security.age |  age -d -i .key.tmp

# checkout operations
rm .key.tmp
