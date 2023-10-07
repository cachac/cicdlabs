#!/bin/bash -x

echo "Installing Microk8s" >> /home/ubuntu/install.txt
echo "token: ${TOKEN}" >> /home/ubuntu/install.txt

sudo snap install microk8s --classic
sudo microk8s status --wait-ready >> /home/ubuntu/install.txt
sudo usermod -a -G microk8s kube
newgrp microk8s

echo "Joining Node" >> /home/ubuntu/install.txt
sudo microk8s join ${TOKEN} >> /home/ubuntu/install.txt

echo "End." >> /home/ubuntu/install.txt



