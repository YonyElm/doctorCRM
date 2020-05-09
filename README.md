# Dr.CRM

Dr.CRM is patient management sample, helping you following up with treatments given to different patients.

## Requirements

* PostgressSQL
* Python > 3.6

## Getting started

1. Build working environment:
    * `make install-requirements`
    * `make build-workdir`
    * `source venv/bin/activate`
    * `python src/manage.py migrate`
1. Start application:
    * `make start-django`
1. Create a Django admin user for the website:
    * `python src/manage.py createsuperuser`
1. Load DB example to get things going faster
    * `make load-example-db`
1. Open the browser with address `localhost:8000`

## Decision making

1. Why NGINX?
    1. Web server I worked with before
    1. Taking unnecessary load from Django when serving static files, and increase performance in production
1. Why uSWGI?
    1. Naively supported by NGINX
1. Why Python?
    1. Python was chosen based on a fact that its an easy language to work with.
1. Why Django framework?
    1. Django is a Python framework for Web Development.
1. Why PostgresSQL?
    1. PostgresSQL is one of the DB officially supported by Django framework

---

### Credits

#### CSS

https://www.free-css.com/free-css-templates/page245/life-care
