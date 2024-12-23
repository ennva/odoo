#!/bin/bash

STEP2=false

## Check Python version
PYTHON_VERSION=`python -c 'import sys; version=sys.version_info[:3]; print("{0}.{1}.{2}".format(*version))'`
PYTHON_MINOR_VERSION=`python -c 'import sys; version=sys.version_info[1]'`

if [ $PYTHON_MINOR_VERSION >= "10" ]; then
    echo -e "Your python version is: "$PYTHON_VERSION
    #echo -e $USER
else
    echo -e "Your python version is: "$PYTHON_VERSION"
    echo -e "Odoo 18 need Python 3.10 or later.
    exit 0
fi

if [ "$STEP2" = true ]; then
    # Install PostgreSQL
    sudo apt install postgresql postgresql-client
    sudo -u postgres createuser -d -R -S $USER
    createdb $USER

    # Create a virtual environment with python 3.10
    python -m venv odoo-py3.10
    source odoo-py3.10/bin/activate

    # Install dependencies
    pip install -r requirements.txt


    # For right-to-left interface (such as Arabic or Hebrew)
    #sudo npm install -g rtlcss

    # Create a folder for new odoo addons modules
    mkdir ../odoo-new-addons

    # Run odoo
    python3 odoo-bin --addons-path=addons -d $USER -i base

    # go to http://localhost:8069/ and log with "admin" "admin"

fi