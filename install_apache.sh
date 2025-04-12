# Updated packages on Amzon Linux 2
sudo dnf update -y

# Install Apache
sudo dnf install -y httpd  
sudo systemctl start httpd
sudo systemctl enable httpd

