#!/usr/bin/env bash
set -euo pipefail

echo "Running post-provision setup..."

sudo yum update -y || sudo apt-get update -y
sudo yum install -y nginx || sudo apt-get install -y nginx

sudo systemctl enable nginx
sudo systemctl start nginx

echo "Setup complete."
