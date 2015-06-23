#!/bin/bash
echo "------ Starting APP ------"
if [ $CF_INSTANCE_INDEX = "0" ]; then
    echo "----- Migrate Database -----"
    python manage.py db migrate
    echo "----- Apply Migrations -----"
    python manage.py db upgrade
    echo "----- Load Database -----"
    python manage.py update_database
    echo "----- build app ------"
fi
python manage.py build
gunicorn quotas:app --log-file -
