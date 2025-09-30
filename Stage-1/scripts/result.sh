#!/bin/bash
set -e

# Remove old Docker packages if they exist
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
  apt-get remove -y $pkg || true
done

# Update and install prerequisites
apt-get update -y
apt-get install -y ca-certificates curl gnupg lsb-release

# Add Docker’s official GPG key
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo ${UBUNTU_CODENAME:-$VERSION_CODENAME}) stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine, containerd, and Compose plugin
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable and start Docker
systemctl enable docker
systemctl start docker

# Add ubuntu user to docker group
usermod -aG docker ubuntu

#install aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
unzip awscliv2.zip
sudo ./aws/install
./aws/install -i /usr/local/aws-cli -b /usr/local/bin

#Pull params from SSM

REDIS_HOST=$(aws ssm get-parameters --region us-east-1 --names REDIS_HOST --query Parameters[0].Value)
REDIS_HOST=$(echo $REDIS_HOST | tr -d '"')

POSTGRES_USER=$(aws ssm get-parameters --region us-east-1 --names POSTGRES_USER --query Parameters[0].Value)
POSTGRES_USER=$(echo $POSTGRES_USER | tr -d '"')

POSTGRES_PASSWORD=$(aws ssm get-parameters --region us-east-1 --names POSTGRES_PASSWORD --query Parameters[0].Value)
POSTGRES_PASSWORD=$(echo $POSTGRES_PASSWORD | tr -d '"')

POSTGRES_DB=$(aws ssm get-parameters --region us-east-1 --names POSTGRES_DB --query Parameters[0].Value)
POSTGRES_DB=$(echo $POSTGRES_DB | tr -d '"')

POSTGRES_HOST=$(aws ssm get-parameters --region us-east-1 --names POSTGRES_HOST --query Parameters[0].Value)
POSTGRES_HOST=$(echo $POSTGRES_HOST | tr -d '"')


# Clone repo (HTTPS is safer for automation)
git clone https://github.com/isrealei/barilon-projects.git

cd barilon-projects/Stage-1/result

# Create or overwrite .env file with REDIS_HOST
echo "REDIS_HOST=${REDIS_HOST}" > .env
echo "POSTGRES_USER=${POSTGRES_USER}" >> .env
echo "POSTGRES_PASSWORD=${POSTGRES_PASSWORD}" >> .env
echo "POSTGRES_DB=${POSTGRES_DB}" >> .env
echo "POSTGRES_HOST=${POSTGRES_HOST}" >> .env   

# Build and run container
docker compose up -d --build
