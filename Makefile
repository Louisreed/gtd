PIP=env/bin/pip
PYTHON=env/bin/python
MANAGESCRIPT=./manage.py
PYTHONLIBS=uwsgi Django

default: install upgrade build

install:
	sudo pipenv --python 3.9
	sudo pipenv install
	sudo pipenv shell

collectstatic: install
	$(MANAGESCRIPT) collectstatic --noinput

update: upgrade

upgrade:
	pipenv install

clean:
	rm -rf env

migrate:
	./manage.py migrate

build: 
	$(MANAGESCRIPT) makemigrations
	$(MANAGESCRIPT) migrate

run: build
	$(MANAGESCRIPT) runserver

resetdatamodel:
	find . -not \( -path  ./env -prune \) -not -name __init__.py -wholename \*migrations\*.py -exec rm \{\} \;
