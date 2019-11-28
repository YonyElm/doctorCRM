install-requirements:
	sudo apt install -y python3-pip python3-dev libpq-dev postgresql-10
	sudo python3 -m pip install virtualenv

build-workdir:
	virtualenv venv --python /usr/bin/python3
	bash -c "source venv/bin/activate; \
			pip install -e .;"

start-db:
	sudo docker-compose up -d --force-recreate

db-cli:
	psql -h localhost -p 5000 -U user -d doctorCRM
