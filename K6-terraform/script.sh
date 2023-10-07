#!/bin/bash -x

echo "Installing Microk8s" >> /home/ubuntu/install.txt

sudo snap install microk8s --classic
sudo microk8s status --wait-ready >> /home/ubuntu/install.txt
sudo usermod -a -G microk8s ubuntu
newgrp microk8s
sudo microk8s.enable dns dashboard storage ingress
mkdir /home/ubuntu/.kube
sudo microk8s config > /home/ubuntu/.kube/config

# cambiar a la versión kubectl requerida.
echo "Installing Kubectl" >> /home/ubuntu/install.txt
sudo snap install kubectl --classic

echo "Add Node" >> /home/ubuntu/install.txt
sudo microk8s add-node > /tmp/raw-token
sed -n '2p' /tmp/raw-token  | sed  -e 's/microk8s join //' > /tmp/token

echo "End." >> /home/ubuntu/install.txt

