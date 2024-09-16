#!/bin/bash

# Update the package list and upgrade the system
echo "Updating package list and upgrading system..."
sudo apt update && sudo apt upgrade -y

# Install basic utilities
echo "Installing basic utilities: htop, curl, wget, vim, and net-tools..."
sudo apt install -y htop curl wget vim net-tools

# Install and configure OpenSSH Server
echo "Installing OpenSSH Server..."
sudo apt install -y openssh-server

# Enable SSH to start on boot and start SSH service
echo "Enabling SSH service on boot and starting it..."
sudo systemctl enable ssh
sudo systemctl start ssh

# Allow SSH through the firewall if UFW is enabled
if sudo ufw status | grep -q "Status: active"; then
    echo "Allowing SSH through the firewall..."
    sudo ufw allow ssh
else
    echo "Firewall is not active, skipping SSH firewall configuration."
fi

# Install Oh My Bash
echo "Installing Oh My Bash..."
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

# Source the bashrc file to apply Oh My Bash settings
echo "Sourcing .bashrc to apply Oh My Bash settings..."
source ~/.bashrc

# Display SSH service status
echo "SSH service status:"
sudo systemctl status ssh --no-pager

echo "Installation complete. You can now connect to the server via SSH."
