#!/bin/bash

# Test script for ck_Ip function

# Mock functions
get_myIP() {
    echo "8.8.8.8" # Mocked IP address
}

is_china_ip() {
    local IP="$1"
    if [ "$IP" = "8.8.8.8" ]; then
        echo "0" # Mocked response for non-China IP
    else
        echo "1" # Mocked response for China IP
    fi
}

# Source the original script
source /root/bestHosts/bin/server/getbestHosts.sh

# Test ck_Ip function
test_ck_Ip() {
    local result
    result=$(ck_Ip)
    if [ "$result" = "0" ]; then
        echo "Test passed: IP is outside China"
    else
        echo "Test failed: IP is incorrectly identified as inside China"
    fi
}

# Run the test
test_ck_Ip