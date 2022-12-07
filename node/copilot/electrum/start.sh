#!/bin/sh

mkdir /log
## Redirecting Filehanders
ln -sf /proc/$$/fd/1 /log/stdout.log
ln -sf /proc/$$/fd/2 /log/stderr.log

mkdir -p /root/electrum_data/electrumx

export COIN='Garlicoin'
export DB_DIRECTORY='/root/electrum_data/electrumx'
export CACHE_MB='512'
export MAX_SESSIONS='100'

echo "DAEMON_URL=$DAEMON_URL"
export ALLOW_ROOT='true'

export REPORT_SSL_PORT='50002'

export SERVICES=tcp://0.0.0.0:50001,ssl://0.0.0.0:50002,wss://0.0.0.0:50004,rpc://0.0.0.0:8000
export HOST=''

export PEER_DISCOVERY='on'
export PEER_ANNOUNCE='on'

echo "$SERVER_CRT" > /root/server.crt
echo "$SERVER_KEY" > /root/server.key

# Start the electrum process
/usr/local/bin/electrumx_server