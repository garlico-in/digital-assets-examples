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
export DAEMON_URL=""
echo "DAEMON_URL=$DAEMON_URL"
export ALLOW_ROOT='true'

export SSL_PORT='50002'
export WSS_PORT='50004'
export REPORT_SSL_PORT='50002'
export REPORT_WSS_PORT='50004'

export SERVICES="ssl://0.0.0.0:50002,wss://0.0.0.0:50004,rpc://0.0.0.0:8000"
export REPORT_SERVICES="ssl://0.0.0.0:50002,wss://0.0.0.0:50004,rpc://0.0.0.0:8000"
export HOST='0.0.0.0'

export PEER_DISCOVERY='on'
export PEER_ANNOUNCE='on'

export LOG_LEVEL='debug'

export SERVER_CRT=''
export SERVER_KEY=''

echo "$SERVER_CRT" > /root/server.crt
echo "$SERVER_KEY" > /root/server.key

export SSL_CERTFILE='/root/server.crt'
export SSL_KEYFILE='/root/server.key'

# Start the electrum process
/root/electrumx/electrumx_server