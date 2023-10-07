#!/bin/bash -x

echo "Installing Microk8s" >> /home/ubuntu/install.txt

sudo snap install microk8s --classic
sudo microk8s status --wait-ready >> /home/ubuntu/install.txt
sudo usermod -a -G microk8s kube
newgrp microk8s

echo "Join Node" >> /home/ubuntu/install.txt
microk8s join 172.17.0.1:25000/4b7fb85e6f00935265c675f00917bc94/79e8fb3f68e7

echo "End." >> /home/ubuntu/install.txt



