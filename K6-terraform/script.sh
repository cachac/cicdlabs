#!/bin/bash -x

echo "Installing Microk8s" >> /home/ubuntu/install.txt

sudo snap install microk8s --classic
sudo microk8s status --wait-ready >> /home/ubuntu/install.txt
sudo usermod -a -G microk8s kube
newgrp microk8s
sudo microk8s.enable dns dashboard storage ingress
mkdir .kube
microk8s config > ~/.kube/config

# cambiar a la versión kubectl requerida.
echo "Installing Kubectl" >> /home/ubuntu/install.txt
sudo snap install kubectl --classic

echo "Add Node" >> /home/ubuntu/install.txt
microk8s add-node --token $MICROK8S_TOKEN

echo "End." >> /home/ubuntu/install.txt

