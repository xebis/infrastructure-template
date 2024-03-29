#!/usr/bin/env bash
# shellcheck disable=SC2317
set -euo pipefail
IFS=$'\n\t'
LANG=C

setup() {
    load 'helpers/bats-support/load'
    load 'helpers/bats-assert/load'

    export TEST_ARGV=('scripts/bootstrap')

    . scripts/bootstrap
}

@test 'scripts/bootstrap install_dependencies test' {
    function apt_add() {
        return 0
    }
    export -f apt_add

    function lsb_release() {
        return 0
    }
    export -f lsb_release

    function pkgs() {
        echo 'OK'
    }
    export -f pkgs
    function pip() {
        echo 'OK'
    }
    export -f pip

    run install_dependencies

    assert_line -n 0 'OK'
    assert_line -n 1 'OK'
}
