#!/bin/sh

# We may need to eval LOGS_LOCATION at runtime since it may have been injected it via case docker-compose env var which could
# require a recursive lookup to 'follow' environment variables to get to then real value (hence, 'eval').
echo "Checking to see if LOGS_LOCATION has been overridden with an env var as the value..."
LOGS_LOCATION=$(eval "echo ${LOGS_LOCATION}")
echo "Using LOGS_LOCATION=${LOGS_LOCATION}"

/usr/sbin/httpd;
tail -f /var/www/logs/*.log