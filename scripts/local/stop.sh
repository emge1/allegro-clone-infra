#!/usr/bin/env bash

vagrant ssh -c "
  cd /home/vagrant/app &&
  docker-compose down
"

vagrant halt