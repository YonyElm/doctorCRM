#!/bin/bash

# Configuration for Streaming Replication
# This file will run only once when Postgres is being initiated
# Once Server is up, this script is being skipped

# CONFIGURE PRIMARY DATABASE
if [[ -z $REPLICATE_FROM ]]; then

    psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} -c "SET password_encryption = 'scram-sha-256'; CREATE ROLE $REPLICA_POSTGRES_USER WITH REPLICATION PASSWORD '$REPLICA_POSTGRES_PASSWORD' LOGIN;"

    # Add replication settings to primary postgres conf (happens on replica also)
    cat >> ${PGDATA}/postgresql.conf <<EOF
    listen_addresses= '*'
    wal_level = replica
    max_wal_senders = 2
    max_replication_slots = 2
    synchronous_commit = ${SYNCHRONOUS_COMMIT}
EOF

    #( SYNCHRONOUS_COMMIT always off now)
    # Add synchronous standby names if we're in one of the synchronous commit modes
    if [[ "${SYNCHRONOUS_COMMIT}" =~ ^(on|remote_write|remote_apply)$ ]]; then
        cat >> ${PGDATA}/postgresql.conf <<EOF
        synchronous_standby_names = '1 (${REPLICA_NAME})'
EOF
    fi

    # Add replication settings to primary pg_hba.conf
    # Using the hostname of the primary doesn't work with docker containers, so we resolve to an IP using getent,
    # or we use a subnet provided at runtime.
    if  [[ -z $REPLICATION_SUBNET ]]; then
        REPLICATION_SUBNET=$(getent hosts ${REPLICATE_TO} | awk '{ print $1 }')/32
    fi

    # host     replication     repuser   172.19.0.3/32       scram-sha-256
    cat >> ${PGDATA}/pg_hba.conf <<EOF
    host     replication     ${REPLICA_POSTGRES_USER}   ${REPLICATION_SUBNET}       scram-sha-256
EOF

    # Restart postgres and add replication slot
    pg_ctl -D ${PGDATA} -m fast -w restart
    psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} -c "SELECT * FROM pg_create_physical_replication_slot('${REPLICA_NAME}_slot');"

fi

# CONFIGURE REPLICA DATABASE, Run only on the first time DB starts 
if [[ -z $REPLICATE_TO ]]; then

    # Stop postgres instance and clear out PGDATA
    pg_ctl -D ${PGDATA} -m fast -w stop
    rm -rf ${PGDATA}

    # Create a pg pass file so pg_basebackup can send a password to the primary
    cat > ~/.pgpass.conf <<EOF
    *:5432:${MASTER_DB_NAME}:${POSTGRES_USER}:${POSTGRES_PASSWORD}
EOF
    #chown ${POSTGRES_USER}:${POSTGRES_PASSWORD} ~/.pgpass.conf
    chmod 0600 ~/.pgpass.conf

    # Backup replica from the primary
    until PGPASSFILE=~/.pgpass.conf pg_basebackup -h ${REPLICATE_FROM} -D ${PGDATA} -U ${POSTGRES_USER} -vP -w
    do
        # If docker is starting the containers simultaneously, the backup may encounter
        # the primary amidst a restart. Retry until we can make contact.
        sleep 1
        echo "Retrying backup . . ."
    done

    # Remove pg pass file -- it is not needed after backup is restored
    # rm ~/.pgpass.conf

    # Create the recovery.conf file so the backup knows to start in recovery mode (Postgres11 and below)
    # cat > ${PGDATA}/recovery.conf <<EOF
    # standby_mode = on
    # primary_conninfo = 'host=${REPLICATE_FROM} port=5432 user=${POSTGRES_USER} password=${POSTGRES_PASSWORD} application_name=${REPLICA_NAME}'
    # primary_slot_name = '${REPLICA_NAME}_slot'
    # EOF
    touch ${PGDATA}/standby.signal

    # Ensure proper permissions on recovery.conf
    # chmod 0600 ${PGDATA}/recovery.conf
    #chown ${POSTGRES_USER}:${POSTGRES_PASSWORD} ${PGDATA}/standby.signal
    chmod 0600 ${PGDATA}/standby.signal

    pg_ctl -D ${PGDATA} -w start

fi
