==================
Django Vue Starter
==================

A setup to start a Django+Vue.JS project. Following tools are used/installed as part of the project.

* pip for python module management.
* yarn for js module management.
* vue-roter for Vue routes handling.
* Vuetify vue plugin.
* `django-webpack-loader <https://github.com/owais/django-webpack-loader>`  to connect Django and Vue.JS.
* `python-decouple <https://github.com/henriquebastos/python-decouple>`_ to manage project settings.
* django-simplest as the REST API.


Requirements
------------

* A python virtualenv manager of your choice.
* Create a new python virtualenv and switch to it.
* Install yarn globally.
* Install Vue.JS globally::
      yarn global add @vue/cli


Usage
-----

* Clone this repo locally.
* Run setup.sh::
      ./setup.sh project-path project-name
  * Example::
        ./setup.sh /Users/john/work my_project

    This will start a Django project named my_project in /Users/john/work/my_project

* Add webpack_loader into Django `INSTALLED_APPS <https://docs.djangoproject.com/en/3.0/ref/settings/#installed-apps>`_

  .. code-block::
     INSTALLED_APPS = [
         'django.contrib.admin',
         'django.contrib.auth',
         'django.contrib.contenttypes',
         'django.contrib.sessions',
         'django.contrib.messages',
         'django.contrib.staticfiles',
         'webpack_loader',
     ]

* Start Django (cd into project root)::
      python manage.py runserver

* Start yarn dev server ( cd in project-root/ui)::
      yarn serve

* visit localhost:8000 in your web browser


Notes
-----
* Vue files are in the a directory called `ui` in project root.
* The entry path to the app is at / and it is served from a view called `index` at project-root/views.py and project-root/urls.py
