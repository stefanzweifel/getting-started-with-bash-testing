#!/usr/bin/env bats

load '../node_modules/bats-support/load'
load '../node_modules/bats-assert/load'

setup() {
    # Add code which should be executed before each test case
    export MY_SCRIPT_PATH_FOR_NEW_FILES=~/Desktop
}

teardown() {
    rm -rf ${MY_SCRIPT_PATH_FOR_NEW_FILES}/file-*.txt
}

@test "It Works" {
    # Arrange
    # Prepare "the world" for your test

    # Act
    # Run your code
    result="$(echo 2+2 | bc)"

    # Assert
    # Make assertions to ensure that the code does what it should
    [ "$result" -eq 4 ]
    assert_equal "$result" 4
}

@test "It creates 3 txt files" {
    # Run our script.
    # We use $BATS_TEST_DIRNAME here, as the tests
    # are executed in a temporary directory. The
    # variable gives us the absolute path to
    # the testing directory
    run "${BATS_TEST_DIRNAME}"/../main.sh

    # Assert that the script has run successfully
    assert_success

    # Execute `ls` to return a list of
    # all the files in the directory
    run ls ${MY_SCRIPT_PATH_FOR_NEW_FILES}

    # Assert against the output of `ls` that
    #  file-1.txt, file-2.txt and file-3.txt exist
    assert_output --partial 'file-1.txt'
    assert_output --partial 'file-2.txt'
    assert_output --partial 'file-3.txt'
}
