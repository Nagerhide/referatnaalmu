#!/usr/bin/env bash

TEST_DIR="Tests/"

Seeds=(
    170639108,
    276327338,
    416729754,
    979536843,
    242517626,
    696650014,
    398550183,
    399124795,
    974406218,
    814308964
)

N=(
    1,
    2,
    5,
    10,
    20,
    50,
    100,
    200,
    500,
    1000
)
j=0
i=1
g++ testgen.cpp -o testgen

for seed in "${Seeds[@]}"; do
    ./testgen "$seed" "${N[j]}}" > "${TEST_DIR}t_$i.in"



    i=$((i + 1))
    j=$((j + 1))
done

rm testgen
