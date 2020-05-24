#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

for file in "$SCRIPT_DIR"/*.csv; do
  sudo docker cp "$file" postgres_db:/tmp/;
done;

echo "Using postgress username='user' for this example."
echo "The default password for 'user' is 123456789"
psql -h localhost -p 5000 -U user -d doctorCRM -c "COPY app_doctor FROM '/tmp/app_doctor.csv' DELIMITER ',' CSV HEADER;"
psql -h localhost -p 5000 -U user -d doctorCRM -c "COPY app_patient FROM '/tmp/app_patient.csv' DELIMITER ',' CSV HEADER;"
psql -h localhost -p 5000 -U user -d doctorCRM -c "COPY app_test FROM '/tmp/app_test.csv' DELIMITER ',' CSV HEADER;"
psql -h localhost -p 5000 -U user -d doctorCRM -c "COPY app_trackingchart FROM '/tmp/app_trackingchart.csv' DELIMITER ',' CSV HEADER;"