#!/bin/bash

<< task 
deploy django app and handle the error
task

code_clone(){
	echo cloning the app from git...
	git clone https://github.com/LondheShubham153/django-notes-app.git
}

#installing dependencies
install_dep(){
	sudo apt-get update
	sudo apt-get install docker.io nginx -y
}

#required restarts
req_restart(){
	sudo systemctl enable docker
	sudo systemctl enable nginx
	sudo systemctl restart docker
}

#deployment
deploy(){
	#sudo chown $USER /var/run/docker.sock
	docker build -t notes-app .
	docker run -d -p 8000:8000 notes-app:latest
}

if ! code_clone 
then
	cd django-notes-app
fi

if ! install_dep 
then
	echo installation failed
	exit 1
fi

if ! req_restart
then
	exit 1
fi

if ! deploy 
then
	echo deployment failed
	exit 1
fi
