#!/bin/sh

HOOK_PATH="toolkit/hooks/commit-msg"

test_commit_msg() {
    local msg="$1"
    local description="$2"
    echo "Testing: $description"
    
    echo "$msg" > test_msg.txt
    sh "$HOOK_PATH" test_msg.txt > test_output.txt 2>&1
    local exit_code=$?
    
    echo "Exit code: $exit_code"
    echo "Output:"
    cat test_output.txt
    echo "----------------------------------------"
    return $exit_code
}

# 1. Test message with comments
COMMENTED_MSG="feat: something

# This is a comment
#   Another comment
  # Comment with leading whitespace

body of the message"

test_commit_msg "$COMMENTED_MSG" "Message with comments (should fail current, pass after fix)"

# 2. Test message that should FAIL validation but has comments
INVALID_MSG="feat: something
# Comment
invalid line"

test_commit_msg "$INVALID_MSG" "Invalid message with comments (should FAIL after stripping)"

# 3. Test message that should PASS validation
VALID_MSG="feat: something

This is a valid body.

Footer: value"

test_commit_msg "$VALID_MSG" "Valid message without comments (should PASS)"

rm test_msg.txt test_output.txt
