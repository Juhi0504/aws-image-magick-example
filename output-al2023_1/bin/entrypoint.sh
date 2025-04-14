#!/bin/bash
export LD_LIBRARY_PATH=/usr/local/lib64:/usr/local/lib:/usr/lib64:$LD_LIBRARY_PATH
exec "$@"
