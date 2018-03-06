# Installation for kolla

```bash
sudo yum install -y epel-release python-pip python-devel libffi-devel gcc openssl-devel ansible
curl -sSL https://get.docker.io | sudo bash
sudo systemctl enable docker && sudo systemctl start docker
sudo usermod -aG docker `whoami`
sudo su - `whoami`
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo tee /etc/systemd/system/docker.service.d/kolla.conf <<-'EOF'
[Service]
MountFlags=shared
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo pip install -U docker
sudo yum install -y ntp
sudo systemctl enable ntpd.service
sudo systemctl start ntpd.service
sudo pip install kolla-ansible
sudo cp -r /usr/share/kolla-ansible/etc_examples/kolla /etc/kolla/
