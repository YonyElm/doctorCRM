# coding=utf-8
from django.conf import settings
from datetime import datetime
import socket, os


def test_connection_to_db(database_name):
    try:
        db_definition = getattr(settings, 'DATABASES')[database_name]
        s = socket.create_connection((db_definition['HOST'], db_definition['PORT']), 5)
        s.close()
        return True
    except Exception as e:
        return False


def available_db():
    # TBD: Code depends on the fail that the file exists and has values in it.
    # Create a code in which this file is being created if issue comes
    with open(os.path.dirname(__file__) + '/dbha_last_check.txt', 'r') as f:
        f = f.read().splitlines()
        dbha_last_check = datetime.strptime(f[0], '%Y-%m-%d %H:%M:%S')
        last_db = f[1]
    if (datetime.now() - dbha_last_check).seconds > 10:
        if test_connection_to_db('default'):
            db = 'default'
        elif test_connection_to_db('standby1'):
            db = 'standby1'

        with open(os.path.dirname(__file__) + '/dbha_last_check.txt', 'w') as status_file:
            lines_of_text = datetime.now().strftime('%Y-%m-%d %H:%M:%S') + "\n" + db
            status_file.write(lines_of_text)
            status_file.close()

        return db

    return last_db


class ModelDatabaseRouter(object):

    def db_for_read(self, model, **hints):
        """Point all read operations to our available dbms server"""
        return available_db()

    def db_for_write(self, model, **hints):
        """Point all write operations to our available dbms server"""
        return available_db()
