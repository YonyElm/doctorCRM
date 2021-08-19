# Dr.CRM

Dr.CRM is patient management sample, helping you following up with treatments given to different patients.

## Requirements

* PostgreSQL
* Python > 3.5

## Getting started

1. Build working environment:
    * `make install-requirements`
    * `make build-workdir`
    * `source venv/bin/activate`
    * `make start-db`
    * `python src/manage.py migrate`
1. Create a Django admin user for the website:
    * `python src/manage.py createsuperuser`
1. Load DB example to get things going faster (can be skipped):
    * `make load-example-db`
1. Start application:
    * `make start-django`
1. Open the browser with address `localhost:8000`

## Decision making

1. Why NGINX?
    1. Web server I worked with before
    1. Taking unnecessary load from Django when serving static files, and increase performance in production
    1. Serves load balancer
1. Why uSWGI?
    1. Natively supported by NGINX
1. Why Redis Cache?
    1. To speed up page fetching by caching processed pages
1. Why Python?
    1. Python was chosen based on a fact that its an easy language to work with.
1. Why Django framework?
    1. Django is a Python framework for Web Development.
1. Why PostgresSQL?
    1. PostgresSQL is one of the DB officially supported by Django framework
1. Why React?
    1. Some pages holds information that can server different needs. These pages can introduce SPA elements to speed up process and ease on usage.
---

### Credits

#### CSS

https://www.free-css.com/free-css-templates/page245/life-care
