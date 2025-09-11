#/bin/bash

# roll through all subfolders and run install.sh
for dir in */ ; do
    if [ -d "$dir" ]; then
        if [ -f "$dir/install.sh" ]; then
            echo "Running install.sh in $dir"
            (cd "$dir" && ./install.sh)
        else
            echo "No install.sh found in $dir"
        fi
    else
        echo "$dir is not a directory"
    fi
done
echo "All install scripts executed."
exit 0
