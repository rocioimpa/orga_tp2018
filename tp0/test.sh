## PARA NETBSD
#!/usr/pkg/bin/bash

#!/bin/bash

# If number of arguments less then 1; print usage and exit
if [ $# -lt 1 ]; then
    printf "Usage: %s <application>\n" "$0" >&2
    exit 1
fi

bin="$1"           # The application (from command arg)
diff="diff -iad"   # Diff command, or what ever

test_file() {
    # Padd file_base with suffixes
    file_in="$2.in"             # The in file
    file_out_val="$2.out"       # The out file to check against
    file_out_tst="$2.out.tst"   # The outfile from test application

    # Validate infile exists (do the same for out validate file)
    if [ ! -f "$file_in" ]; then
        printf "In file %s is missing\n" "$file_in"
        return 1;
    fi
    if [ ! -f "$file_out_val" ]; then
        printf "Validation file %s is missing\n" "$file_out_val"
        return 1;
    fi

    printf "Testing against %s\n" "$file_in"

    # Run application, redirect in file to app, and output to out file
    "./$bin" -a "$1" -i "$file_in" -o "$file_out_tst"

    # Execute diff
    $diff "$file_out_tst" "$file_out_val"


    # Check exit code from previous command (ie diff)
    # We need to add this to a variable else we can't print it
    # as it will be changed by the if [
    # Iff not 0 then the files differ (at least with diff)
    e_code=$?
    if [ $e_code != 0 ]; then
            printf "TEST FAIL : %d\n" "$e_code"
    else
            printf "TEST OK!\n"
    fi

    rm $file_out_tst

    # Pause by prompt
    #read -p "Enter a to abort, anything else to continue: " input_data
    # Iff input is "a" then abort
    #[ "$input_data" == "a" ] && return 1
}

# An array, do not have to declare it, but is supposedly faster
declare -a encode_files=("test/encode/M" "test/encode/Ma" "test/encode/zero" "test/encode/yes")
declare -a decode_files=("test/decode/Man" "test/decode/yes" "test/decode/zero")

# Loop the array
for file in "${encode_files[@]}"; do
    test_file "encode" "$file"
done

for file in "${decode_files[@]}"; do
    test_file "decode" "$file"
done


# Clean exit with status 0
exit 0