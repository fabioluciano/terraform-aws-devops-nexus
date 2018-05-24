#!/bin/bash
sudo yum update -y 

# Setting time
rm -f /etc/localtime
ln -s /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
sed  -ie 's/ZONE="UTC"/ZONE="America\/Sao_Paulo"/' /etc/sysconfig/clock

# Configure the cluster
sudo yum install -y aws-cli
aws s3 cp s3://${bucket-name}/ecs.config /etc/ecs/ecs.config

# Mount the EFS 
sudo mkdir /data/
sudo yum install -y amazon-efs-utils && sudo mount -t efs ${efs-id}:/ /data
chown 200 /data -R