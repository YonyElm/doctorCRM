# Step 1
install-requirements:
	sudo apt install -y python3-pip python3-dev libpq-dev
	# sudo apt install -y nginx postgresql-10
	sudo python3 -m pip install virtualenv

# Step 2
build-workdir:
	virtualenv venv --python /usr/bin/python3
	bash -c "source venv/bin/activate; \
			pip install -e .;"
# Step 3
django-commit:
	bash -c "source venv/bin/activate; \
			cd src; \
			python3 manage.py migrate;"

# Step 4 - development
start-django: start-db
	bash -c "source venv/bin/activate; \
			cd src; \
			python3 manage.py runserver;"

# Step 4 - production (In example nginx used as web-server+load-balancer between ports 8001/8002)
start-nginx:  start-db
	sudo docker start nginx
	bash -c "source venv/bin/activate; \
			cd src; \
			uwsgi --socket :8001 --module project.wsgi & \
			uwsgi --socket :8002 --module project.wsgi;" # refering to path src/project/wsgi.py 

### Postgres DB

start-db:
	sudo docker-compose up -d --force-recreate
	sudo docker stop nginx

db-cli:
	psql -h localhost -p 5000 -U user -d doctorCRM

save-db-snapshot:
	./etc/db-example/postgres-to-csv.sh

# Step 5
load-example-db:
	./etc/db-example/csv-to-postgres.sh
	
