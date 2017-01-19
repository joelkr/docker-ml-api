#!/bin/bash
set -e
if [ "$ENV" = 'UNIT' ]; then
    echo "$ENV"
    echo "Running Unit Tests"
    exec /usr/bin/python3 "/home/mlapi/python-app/tests.py"
else
    echo "$ENV"
    echo "Running Development Server"
    exec /usr/bin/python3 "/home/mlapi/python-app/flask-web.py"
