#!/bin/sh

mkdir /root/garlicoin_data/garlicoind

rm /root/garlicoin_data/debug.log

## Pre execution handler
pre_execution_handler() {
  ## Pre Execution
  echo "pre_execution"
}

## Post execution handler
post_execution_handler() {
  ## Post Execution
  echo "post_execution"
  echo "wait 5s"
  sleep 5
  echo "finished"
}

## Sigterm Handler
sigterm_handler() { 
  if [ $pids -ne 0 ]; then
    # the above if statement is important because it ensures 
    # that the application has already started. without it you
    # could attempt cleanup steps if the application failed to
    # start, causing errors.
    kill -15 "$pids"
    wait "$pids"
    post_execution_handler
  fi
  exit 143; # 128 + 15 -- SIGTERM
}

## Setup signal trap
# on callback execute the specified handler
trap 'sigterm_handler' TERM

## Initialization
pre_execution_handler

## Start Process
# run process in background and record PID
pids=""
RESULT=0

echo "start garlicoind"

REINDEX_FLAG=`aws ssm get-parameter --name "/copilot/applications/$COPILOT_APPLICATION_NAME/$COPILOT_ENVIRONMENT_NAME/garlicoin-node/reindex" | jq -r '.Parameter | .Value'`
echo "REINDEX_FLAG:$REINDEX_FLAG"

reindex=""
if [ "${REINDEX_FLAG}" != "None" ]; then
  echo "reindex"
  aws ssm put-parameter --name "/copilot/applications/$COPILOT_APPLICATION_NAME/$COPILOT_ENVIRONMENT_NAME/garlicoin-node/reindex" --type "String" --value "None" --overwrite
  rm -rf /root/garlicoin_data/garlicoind/blocks/
  rm -rf /root/garlicoin_data/garlicoind/chainstate/
  rm -rf /root/garlicoin_data/garlicoind/index/
  reindex="-reindex"
fi
echo reindex=$reindex

/root/garlicoin/bin/garlicoind $reindex -conf=/root/garlicoin.conf -datadir=/root/garlicoin_data/garlicoind -rpcauth=$RPC_AUTH &
pids="$pids $!"

## Wait until one app dies
for pid in $pids; do
    wait $pid || let "RESULT=1"
done
if [ "$RESULT" == "1" ];
    then
       exit 1
fi
return_code="$?"

## Cleanup
post_execution_handler
# echo the return code of the application
exit $return_code