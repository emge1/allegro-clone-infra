#!/usr/bin/env bash

BASE_DIR="$(dirname "$(realpath "$0")")/../../"

if [ ! -d "$BASE_DIR/allegro-clone-api" ] || [ ! -d "$BASE_DIR/allegro-clone-frontend" ]; then
  echo "Error: UI or API repo not found"
  exit 1
fi

cd "$BASE_DIR/allegro-clone-api" && git checkout main && git pull origin main
cd "$BASE_DIR/allegro-clone-frontend" && git checkout main && git pull origin main

cd "../allegro-clone-infra"
vagrant up --provision


vagrant ssh -c "
  sudo rm -rf /home/vagrant/app
  mkdir -p /home/vagrant/app
  cp -r /vagrant/allegro-clone-api /home/vagrant/app/allegro-clone-api
  cp -r /vagrant/allegro-clone-frontend /home/vagrant/app/allegro-clone-frontend
"

vagrant ssh -c "
  cd /home/vagrant/app &&
  docker-compose up -d
"
