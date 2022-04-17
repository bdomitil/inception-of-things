#! /bin/bash

gitlab_url="bdomitil.dev"

yum install -y curl policycoreutils-python openssh-server perl
# Enable OpenSSH server daemon if not enabled: sudo systemctl status sshd
systemctl enable sshd
systemctl start sshd

# Check if opening the firewall is needed with: sudo systemctl status firewalld
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
systemctl reload firewalld

yum install postfix
systemctl enable postfix
systemctl start postfix

curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash

EXTERNAL_URL="$gitlab_url" yum install -y gitlab-ce