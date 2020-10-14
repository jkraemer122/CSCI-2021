#!/bin/bash


function major_sep(){
    printf '%s\n' '====================================='
}
function minor_sep(){
    printf '%s\n' '-------------------------------------'
}
major_sep
printf "PROBLEM 1A test_batt_update.sh binary tests\n"

generate=1
run_norm=1                                 # run normal tests
run_valg=1                                 # run valgrind tests
valg_penalty_max=8                         # maximum point deduction for valgrind problems
NTESTS=15

# Determine column width of the terminal
if [[ -z "$COLUMNS" ]]; then
    printf "Setting COLUMNS based on stty\n"
    COLUMNS=$(stty size | awk '{print $2}')
fi
if (($COLUMNS == 0)); then
    COLUMNS=126
fi

VALGRIND="valgrind --leak-check=full --show-leak-kinds=all"

INPUT=test-data/input.tmp                   # name for expected output file
EXPECT=test-data/expect.tmp                 # name for expected output file
ACTUAL=test-data/actual.tmp                 # name for actual output file
DIFFOUT=test-data/diff.tmp                  # name for diff output file
VALGOUT=test-data/valgrind.tmp              # name for valgrind output file

# Turn off normal/valgrind test sections
case "$1" in
    norm)
        run_valg=0
        shift
        ;;
    valg)
        run_norm=0
        shift
        ;;
esac

# Run normal tests: capture output and check against expected
if [ "$run_norm" = "1" ]; then
    printf "RUNNING NORMAL TESTS\n"
    ./test_batt_update 2>&1 | tee $ACTUAL
    NPASS=$(gawk '/Score/{printf("%d\n",$2)}' $ACTUAL)

    printf "Finished:\n"
    printf "%2d / %2d Normal correct\n" "$NPASS" "$NTESTS"
    printf "\n"
fi

# ================================================================================

VALGPEN=0
# Run valgrind tests: check only for problems identified by valgrind
if [ "$run_valg" = "1" ]; then
    minor_sep
    printf "RUNNING VALGRIND TESTS\n"

    # run code through valgrind
    echo "> $VALGRIND ./test_batt_update"
    $VALGRIND ./test_batt_update 2>&1 | tee $VALGOUT

    # Check various outputs from valgrind
    if ! grep -q 'ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)' $VALGOUT ||
       ! grep -q 'in use at exit: 0 bytes in 0 blocks'  $VALGOUT ||
         grep -q 'definitely lost: 0 bytes in 0 blocks' $VALGOUT;
    then
        printf "FAIL: Valgrind detected problems\n"
        minor_sep
        VALGPEN=$valg_penalty_max
    else
        printf "Valgrind OK\n"
    fi
    # done
    minor_sep
    printf "Finished:\n"
    printf " -%d Valgrind penalty\n" "$VALGPEN" 
    printf "\n"
fi


major_sep
printf "OVERALL:\n"
printf "%2d / %2d Normal correct\n" "$NPASS" "$NTESTS"
printf " -%d Valgrind penalty\n" "$VALGPEN" 

SCORE=$((NPASS-VALGPEN))
if ((SCORE < 0)); then
    SCORE=0;
fi
printf "RESULTS: %d / %d points for normal/valgrind tests\n" "$SCORE" "$NTESTS"
