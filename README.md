# Dr.CRM

Dr.CRM is patient management sample, helping you following up with treatments given to different patients.

## Requirements

* PostgressSQL
* Python > 3.6

## Getting started

1. Build working environment:
    * `make build-workdir`
    * `source venv/bin/activate`
2. Create a Django admin user for the website:
    * `python src/manage.py createsuperuser`
3. Start Postgres DB:
    * `make start-db`
4. Run application:
    * `make start-app`
5. Load DB example to get things going faster
    * `make load-example-db`
6. Open the browser with address `localhost:8000`

## Deceision making

1. Why Python?
    1. Python was chosen based on a fact that its an easy language to work with.
2. Why Django framework?
    1. Django is a Python framework for Web Development.
3. Why PostgresSQL?
    1. PostgresSQL is one of the DB officially supported by Django framework

---

##### Credits
###### CSS
https://www.free-css.com/free-css-templates/page245/life-care