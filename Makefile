install-requirements:
	sudo apt install -y python3-pip python3-dev libpq-dev postgresql-10 nginx
	sudo python3 -m pip install virtualenv

build-workdir:
	virtualenv venv --python /usr/bin/python3
	bash -c "source venv/bin/activate; \
			pip install -e .;"

django-commit:
	bash -c "source venv/bin/activate; \
			cd src; \
			python3 manage.py migrate;"

start-django: start-db
	bash -c "source venv/bin/activate; \
			cd src; \
			python3 manage.py runserver;"

# Deprecated will be used inside Docker container
start-nginx:
	sudo docker-compose up -d --force-recreate
	bash -c "source venv/bin/activate; \
			cd src; \
			uwsgi --socket :8001 --module project.wsgi;"

### Postgres DB

start-db:
	sudo docker-compose up -d --force-recreate
	sudo docker stop nginx

db-cli:
	psql -h localhost -p 5000 -U user -d doctorCRM

load-example-db:
	./etc/db-example/postgres-to-csv.sh