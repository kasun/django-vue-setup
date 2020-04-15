#!/bin/bash

# ./setup.sh project_path project_name

print_usage() {
    echo "./setup project_path project_name"
}

setup () {
    project_path=$1
    project_name=$2
    if [[ -z $project_path || -z $project_name ]]; then
        echo "Invalid usage."
        print_usage
        return 0;
    fi

    working_dir=`pwd`
    if [[ ! -d "$project_path" ]]; then
        mkdir $project_path
    fi

    cp -r starter_template ${project_path}/
    mv ${project_path}/starter_template ${project_path}/${project_name}
    cd ${project_path}/${project_name}

    pip install -r requirements.txt
    django-admin startproject ${project_name}

    cd -
    cp files/settings.ini ${project_path}/${project_name}/${project_name}/${project_name}/

    cd -
    settings_file=${project_name}/${project_name}/settings.py

    # setup decouple module in the config file
    if ! grep -q "from decouple import config" ${settings_file}; then
        line_no=`grep -n "import os" ${settings_file} | cut -f1 -d:`
        let "line_no=line_no+1"
        sed -i '' ''"$line_no"'i\
        from decouple import config' ${project_name}/${project_name}/settings.py
    fi

    # define TEMPLATES_DIR and FRONTEND_DIR
    base_dir_line_nos=`grep -n "BASE_DIR" ${settings_file} | cut -f1 -d:`
    eval based=($base_dir_line_nos)
    base_dir_line_no=${based[1]}

    if ! grep -q "TEMPLATES_DIR" ${settings_file}; then
        let "base_dir_line_no=base_dir_line_no+1"
        sed -i '' ''"$base_dir_line_no"'i\
        TEMPLATES_DIR = os.path.join(BASE_DIR, "templates")' ${project_name}/${project_name}/settings.py
    fi

    if ! grep -q "FRONTEND_DIR" ${settings_file}; then
        let "base_dir_line_no=base_dir_line_no+1"
        sed -i '' ''"$base_dir_line_no"'i\
        FRONTEND_DIR = os.path.join(BASE_DIR, "ui")' ${project_name}/${project_name}/settings.py
    fi

    # set templates dir
    sed -i '' "s/'DIRS': \[\],/'DIRS': [TEMPLATES_DIR,],/g" ${project_name}/${project_name}/settings.py

    # copy base HTML file
    cd -
    mkdir ${project_path}/${project_name}/${project_name}/templates
    cp files/app.html ${project_path}/${project_name}/${project_name}/templates/

    # copy root urls file and views files
    cp files/urls.py ${project_path}/${project_name}/${project_name}/${project_name}/
    cp files/views.py ${project_path}/${project_name}/${project_name}/${project_name}/
    cp files/api.py ${project_path}/${project_name}/${project_name}/

    if ! grep -q "WEBPACK_LOADER" ${settings_file}; then
        cat files/webpack_settings.txt >> ${project_path}/${project_name}/${project_name}/${project_name}/settings.py
    fi

    # install UI components
    cd -
    cd ${project_name}
    vue create ui
    cd ui
    vue add vuetify
    vue add router
    yarn add --dev webpack-bundle-tracker@0.4.3

    cd ${working_dir}
    cp files/vue.config.js ${project_path}/${project_name}/${project_name}/ui
}

setup $1 $2
