#!/bin/bash
#export LD_LIBRARY_PATH="/opt/oracle_client_10_2"
#export LD_LIBRARY_PATH="/opt/oracle_client_12_2"
#export LD_LIBRARY_PATH="/usr/lib/oracle/12.2/client64/lib"
#export NLS_LANG=SLOVENIAN_SLOVENIA.UTF8

rails server -p 3333 -b 0.0.0.0
#bundle exec sidekiq -e development
