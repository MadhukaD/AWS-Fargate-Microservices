#!/bin/bash

# Update the package list and install prerequisites
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Set up the stable repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

# Update the package list again
sudo apt update

# Install Docker CE
sudo apt install -y docker-ce

# Check Docker version
docker --version

# Check Docker status (non-interactive)
if systemctl is-active --quiet docker; then
    echo "Docker is running."
else
    echo "Docker is not running. Attempting to start Docker..."
    sudo systemctl start docker
    if systemctl is-active --quiet docker; then
        echo "Docker started successfully."
    else
        echo "Failed to start Docker."
        exit 1
    fi
fi

sudo groupadd docker
sudo usermod -aG docker ubuntu
newgrp docker
docker run hello-world
echo "Docker installation and setup completed successfully."

# Create Docker network for monitoring containers
docker network create monitoring || true

# Run Grafana container
docker run -d --name=grafana --network monitoring -p 3000:3000 grafana/grafana

# Create Prometheus configuration file
sudo tee /home/ubuntu/prometheus.yml > /dev/null <<EOF
global:
  scrape_interval: 15s
scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['prometheus:9090']
  - job_name: 'node-exporter'
    static_configs:
      - targets: ['node-exporter:9100']
EOF

# Run Prometheus container
docker run -d --name=prometheus --network monitoring -p 9090:9090 -v /home/ubuntu/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus

# Run Node-Exporter container
docker run -d --name node-exporter --network monitoring -p 9100:9100 prom/node-exporter