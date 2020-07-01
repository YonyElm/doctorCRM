#!/bin/sh

set -x

sudo sed -i "s/!PRIMARY_NODE_URL/${PRIMARY_NODE_URL}/g" /repmgr-primary.conf
sudo sed -i "s/!PRIMARY_NODE_USERNAME/${PRIMARY_NODE_USERNAME}/g" /repmgr-primary.conf
sudo sed -i "s/!PRIMARY_NODE_PASSWORD/${PRIMARY_NODE_PASSWORD}/g" /repmgr-primary.conf
sudo sed -i "s/!MASTER_DB_NAME/${MASTER_DB_NAME}/g" /repmgr-primary.conf
sudo sed -i "s@!PRIMARY_PGDATA@${PRIMARY_PGDATA}@g" /repmgr-primary.conf # escaping '\' character in path

sudo sed -i "s/!STANDBY_NODE_URL/${STANDBY_NODE_URL}/g" /repmgr-standby.conf
sudo sed -i "s/!STANDBY_NODE_USERNAME/${STANDBY_NODE_USERNAME}/g" /repmgr-standby.conf
sudo sed -i "s/!STANDBY_NODE_PASSWORD/${STANDBY_NODE_PASSWORD}/g" /repmgr-primary.conf
sudo sed -i "s/!STANDBY_DB_NAME/${STANDBY_DB_NAME}/g" /repmgr-standby.conf
sudo sed -i "s@!STANDBY_PGDATA@${STANDBY_PGDATA}@g" /repmgr-standby.conf

repmgr -h ${PRIMARY_NODE_URL} -f /repmgr-primary.conf primary register
repmgr -f /repmgr-primary.conf cluster show
repmgr -h ${STANDBY_NODE_URL} -U ${STANDBY_NODE_USERNAME} -d ${STANDBY_DB_NAME} -f /repmgr-standby.conf standby clone --dry-run
repmgr -h ${STANDBY_NODE_URL} -U ${STANDBY_NODE_USERNAME} -d ${STANDBY_DB_NAME} -f /repmgr-standby.conf standby clone
repmgr -f /repmgr-standby.conf standby register
repmgrd -f /repmgr-primary.conf
