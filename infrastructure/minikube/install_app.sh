#!/bin/bash

yum -y install git

su vagrant -c "git clone https://github.com/Romain-Revel/ajc-projet-final.git /home/vagrant/ajc-projet-final.git"
su vagrant -c "cd /home/vagrant/ajc-projet-final.git && git checkout dev && cd manifests && kubectl apply -f ."

echo "Wait for the availability of all pods with the label env=prod"
su vagrant -c "kubectl wait --for=condition=ready pod -l env=prod -n icgroup --timeout=180s"

echo "You can access http://$(ip -f inet addr show enp0s8 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p'):31500 to use the ic-webapp"