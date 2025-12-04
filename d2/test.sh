#!/bin/bash

# Check if a number is repeated with a given block length
is_repeated() {
    local num="$1"
    local n="$2"
    local len=${#num}

    # Number length must be divisible by n
    (( len % n != 0 )) && return 1

    block=${num:0:n}  # first n digits
    for (( i=n; i<len; i+=n )); do
        if [[ "${num:i:n}" != "$block" ]]; then
            return 1
        fi
    done

    return 0
}

# Read from stdin (pipe stderr)
while read -r line; do
    num=$(echo "$line" | awk '{for(i=1;i<=NF;i++) if($i=="num") print $(i+1)}')
    dl=$(echo "$line"  | awk '{for(i=1;i<=NF;i++) if($i=="dl") print $(i+1)}')
    rval=$(echo "$line" | awk '{print $NF}')

    [ -z "$num" ] || [ -z "$dl" ] || [ -z "$rval" ] && continue

    if is_repeated "$num" "$dl"; then
        # Number is repeated
        [ "$rval" -eq 0 ] && echo "ERROR: $num is repeated but r=0"
    else
        # Number is not repeated
        [ "$rval" -eq 1 ] && echo "ERROR: $num is NOT repeated but r=1"
    fi
done

echo "Done."
