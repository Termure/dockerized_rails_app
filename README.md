# README

This a simple Rails application generated using Docker without Ruby installed on the local machine.

#DOCKER USEFUL COMMANDS: 

Documentation: https://docs.docker.com/engine/reference/commandline/run/

list running containers: docker ps
list all images:         docker images
list all containers:     docker ps -a
delete docker container: docker rm ID

creates ruby container with ruby 3.0 image
docker run --rm ruby:3.0 ruby -e "puts :hello"
    --rm [delete container after stop]
    -e   [set environment variable]

creates container with directory /usr/src/app with ruby:3.0 image
docker run -i -t --rm -v ${PWD}:/usr/src/app ruby:3.0 bash
bash [run rails commands, ex: rails new]
    -v   [Bind mount a volume, Here, mounting the local volume meant that the Rails project generated inside the container (within /usr/src/app) remained in
        our local directory, even after the container terminated.]
    -i   [sends commands from bash as input to Docker Daemon which is responsible for start / stop our container.
        If we didn't specify this, the container would terminate immediately, because Bash—receiving no input —would terminate]
    -t   [long-lived interactive Bash session inside a docker container, otherwise bash shell will close quickly]

		-it [shortcut for -i -t]

		sudo chown ioan:ioan -R myapp [by default the project from docker is created by root, in order to edit the project on ubuntu should be specified the 
		                               user and group]

creates the image based on the Dockerfile
docker build .

start up Rails server
docker run -p 3000:3000 ID \
bin/rails s -b 0.0.0.0
    -p [port]		
    -b [bind Ipv4 local machine IP 0.0.0.0]


list IP address of a running container
    docker inspect --format \
        '{{ .NetworkSettings.IPAdress }}' container_id


docker tag 0e51fc469997 dockerized_rails_app
docker tag dockerized_rails_app dockerized_rails_app:1.0

docker build -t dockerized_rails_app .
docker run -p 3000:3000 dockerized_rails_app

list Rake tasks:
docker run --rm dockerized_rails_app bin/rails -T



#DOCKER COMPOSE

docker compose up
docker compose up -d
    -d [messages are not displayed during compose run]

docker compose ps
docker compose stop [All]
docker compose stop docker <service_name>
docker compose stop/start web
docker compose logs -f web
    -f [tells the command to follow the output]

docker compose run --rm web echo 'run a different command'
docker system prun [free unused resources]
docker compose build web
docker compose up -d redis
docker compose run --rm redis redis-cli -h redis
    -h [connect to the host name redis]

docker compose up -d database [start databse service from docker compose]
docker compose run --rm web bin/rails db:create
docker compose up -d --force-recreate web [--force-recreate => recreates the services containers]

docker compose exec web bin/rails generate scaffold User first_name:string last_name:string
docker compose exec web bin/rails db:migrate
docker volume inspect --format '{{ .Mountpoint }}' dockerized_rails_app_db_data

docker build -f Dockerfile.prod -t ioan97/dockerized_rails_app:prod .
    -f [specifies the name of a different filename for Dockerfile]
    -t [tags the image with ioan97/dockerized_rails_app:prod which indicates the repository on Docker Hub with the specific tag prod]
