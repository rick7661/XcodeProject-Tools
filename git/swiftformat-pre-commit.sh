#!/bin/bash

# Configure path so swiftformat is visible
PATH="/usr/local/bin:$PATH"

# Run any personal pre-commit hooks
if [ -d "scripts/hooks/developer_precommit" ]; then
    for file in scripts/hooks/developer_precommit/*; do
        if [ -f "$file" ] && [ -x "$file" ]; then
            "$file" || exit 1
        fi
    done
fi

# Confirm swiftformat is installed
if ! [ -x "$(command -v swiftformat)" ]; then
  echo 'Error: swiftformat is not installed. Run "brew install swiftformat"' >&2
  exit 1
fi

disabled_rules="strongOutlets,unusedArguments,redundantSelf"

# Run swift format on all framework directories
mainproject=`swiftformat ./MainProject/ --disable ${disabled_rules} | grep -n "swiftformat completed. 0/" |cut -f1 -d:`
presentation=`swiftformat ./Presentation/ --disable ${disabled_rules} | grep -n "swiftformat completed. 0/" |cut -f1 -d:`
data=`swiftformat ./Data/ --disable ${disabled_rules} | grep -n "swiftformat completed. 0/" |cut -f1 -d:`
domain=`swiftformat ./Domain/ --disable ${disabled_rules} | grep -n "swiftformat completed. 0/" |cut -f1 -d:`
support=`swiftformat ./Support/ --disable ${disabled_rules} | grep -n "swiftformat completed. 0/" |cut -f1 -d:`

# Concat the line numbers where grep found "swiftformat completed. 0/"
exit_codes=`echo "${mainproject}${presentation}${data}${domain}${support}"`

# Report on code changes and prevent commit from proceeding
if [ ! "$exit_codes" == "22222" ]
then
    echo "Code reformatted! Review changes, stage & commit as necessary."
    echo "----"
    echo "If you believe this is a mistake review 'scripts/hooks/pre-commit' pre commit hook script"
    exit 1
fi

# Ensure that there are no focused tests or contexts

focused_tests=$(egrep -nr "(fit|fcontext|fdescribe)\(\"" MainProject Presentation Domain Data Support)

if [[ ! -z "${focused_tests}" ]]
then
    echo "Focused Tests were found! Please remove them before committing."
    echo "----"
    printf "${focused_tests}\n"
    exit 1
fi
