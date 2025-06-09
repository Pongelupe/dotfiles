# !/bin/bash
port="$1"
kill -9 $(lsof -t -i:$port)

