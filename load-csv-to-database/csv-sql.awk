#!/usr/bin/awk -f

BEGIN {
    FS=",";
    "wc -l < \""ARGV[1]"\"" | getline lineCount; lineCount+=0
}


{
#    print lineCount
#    printf "NR = %d", NR
    printf "("
    for(j=1; j<= NF; j++) {
        printf "'%s'", $j
        if(j != NF) {
            printf ", "
        }
     }
    printf ")"
    if (NR > lineCount) {
        printf ";\n"
    } else {
        printf ",\n"
    }
}

END {
    print "commit;"
}