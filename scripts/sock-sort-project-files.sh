
# XCode writes the project file in an unsorted fashion on any change to the project. This can make mergese extremely difficult. Sorting the project file's contents removes a large amount of merge issues.

set -e

echo "Sorting project files which have been changed ..."

script_name="scripts/SOCK/pysock/sock.py"

function doSort {
    while read file; do
        echo "   Sorting $file"
        python2.7 $script_name $file
    done
}

# Process:
#    1. Find all changed and stages files
#    2. Filter for project files
#    3. Ignore the carthage check out directory
#    4. Pipe through the sort function.

git diff --name-only --cached | grep project\.pbxproj$ | grep -v Carthage/Checkouts | doSort
git diff --name-only | grep project\.pbxproj$ | grep -v Carthage/Checkouts | doSort

echo "Done."
