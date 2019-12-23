#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "The default password for 'user' is 123456789"
psql -h localhost -p 5000 -U user -d doctorCRM -c "COPY app_doctor TO '/tmp/app_doctor.csv' DELIMITER ',' CSV HEADER;"
psql -h localhost -p 5000 -U user -d doctorCRM -c "COPY app_patient TO '/tmp/app_patient.csv' DELIMITER ',' CSV HEADER;"
psql -h localhost -p 5000 -U user -d doctorCRM -c "COPY app_test TO '/tmp/app_test.csv' DELIMITER ',' CSV HEADER;"
psql -h localhost -p 5000 -U user -d doctorCRM -c "COPY app_trackingchart TO '/tmp/app_trackingchart.csv' DELIMITER ',' CSV HEADER;"

sudo docker cp postgres_db:/tmp/app_doctor.csv "$SCRIPT_DIR"/app_doctor.csv;
sudo docker cp postgres_db:/tmp/app_patient.csv "$SCRIPT_DIR"/app_patient.csv;
sudo docker cp postgres_db:/tmp/app_test.csv "$SCRIPT_DIR"/app_test.csv;
sudo docker cp postgres_db:/tmp/app_trackingchart.csv "$SCRIPT_DIR"/app_trackingchart.csv;