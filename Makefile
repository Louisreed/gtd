PIP=env/bin/pip
PYTHON=env/bin/python
MANAGESCRIPT=./manage.py
PYTHONLIBS=uwsgi Django python3-pip

default: install upgrade build

python:
	sudo apt install software-properties-common
	sudo add-apt-repository ppa:deadsnakes/ppa
	sudo apt install python3.9

install:
	pipenv --python 3.9
	pipenv install
	pipenv shell

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

requirements:
	pip freeze > requirements.txt

resetdatamodel:
	find . -not \( -path  ./env -prune \) -not -name __init__.py -wholename \*migrations\*.py -exec rm \{\} \;
