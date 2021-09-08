#!/usr/bin/dumb-init /bin/sh

print_to_s3() {
    echo "printing application.log to s3 service"
    
    aws s3 cp ./log/application.log "s3://test-logs-007396608401"
    
    result=$?
    if [ "$result" -ne 0 ]; then
          echo "transfer went bad"
    else
          echo "everything went well"
    fi
    
    exit
}

trap print_to_s3 SIGTERM

pumactl start
