#!/usr/bin/env bash

encrypted_string="$1"

decrypted_string=$(echo "$encrypted_string" | openssl aes-256-cbc -d -a -pass pass:somepassword)

echo "$decrypted_string"
