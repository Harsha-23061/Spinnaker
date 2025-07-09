#!/bin/bash

# Update system
sudo apt-get update

# Install Java 17 (required for modern Jenkins versions)
sudo apt-get -y install openjdk-17-jdk

# Set Java 17 as default
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-17-openjdk-amd64/bin/java 1
sudo update-alternatives --set java /usr/lib/jvm/java-17-openjdk-amd64/bin/java

# Verify Java version
java -version

# Add Jenkins repo key securely
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Add Jenkins repository using the signed key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | \
  sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update and install Jenkins and Git
sudo apt-get update
sudo apt-get -y install jenkins git

# Start and enable Jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Print Jenkins status
sudo systemctl status jenkins
