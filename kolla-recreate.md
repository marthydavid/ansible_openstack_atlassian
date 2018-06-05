# Kolla Recreate

## CentOS

```bash
echo "`whoami` ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/`whoami`
sudo yum install -y epel-release   &&\
sudo yum install -y python-pip       \
                    python-devel     \
                    libffi-devel     \
                    gcc              \
                    openssl-devel    \
                    ansible          \
                    ntp              \
                    libselinux-python 
sudo systemctl enable ntpd.service
sudo systemctl start ntpd.service
#sudo pip install -U pip
sudo pip install kolla-ansible
sudo cp -r /usr/share/kolla-ansible/etc_examples/kolla /etc/kolla/
sudo cp /usr/share/kolla-ansible/ansible/inventory/* .
pvcreate /dev/vdb
vgcreate cinder-volumes /dev/vdb
sudo sed -i 's/#config_strategy: "COPY_ALWAYS"/config_strategy: "COPY_ALWAYS"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#kolla_base_distro: "centos"/kolla_base_distro: "centos"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#kolla_install_type: "binary"/kolla_install_type: "binary"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#openstack_release: ""/openstack_release: "pike"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#network_interface: "eth0"/network_interface: "eth1"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#neutron_external_interface: "eth1"/neutron_external_interface: "eth2"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#enable_heat: "yes"/enable_heat: "yes"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#enable_grafana: "no"/enable_grafana: "yes"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#enable_horizon: "yes"/enable_horizon: "yes"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#enable_horizon_neutron_lbaas: "{{ enable_neutron_lbaas | bool }}"/enable_horizon_neutron_lbaas: "{{ enable_neutron_lbaas | bool }}"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#enable_central_logging: "no"/enable_central_logging: "yes"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#enable_magnum: "no"/enable_magnum: "yes"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#enable_neutron_lbaas: "no"/enable_neutron_lbaas: "yes"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#nova_compute_virt_type: "kvm"/nova_compute_virt_type: "kvm"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#enable_cinder: "no"/enable_cinder: "yes"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#enable_cinder_backend_lvm: "no"/enable_cinder_backend_lvm: "yes"/g' /etc/kolla/globals.yml && \
##sudo sed -i 's///g' /etc/kolla/globals.yml && \
sudo sed -i 's/10.10.10.254/192.168.1.120/g' /etc/kolla/globals.yml && \
sudo kolla-genpwd && \
sudo kolla-ansible -i /home/`whoami`/all-in-one bootstrap-servers && \
sudo kolla-ansible pull -i /home/`whoami`/all-in-one && \
sudo kolla-ansible -i /home/`whoami`/all-in-one prechecks && \
sudo kolla-ansible -i /home/`whoami`/all-in-one deploy && \
sudo kolla-ansible -i /home/`whoami`/all-in-one post-deploy && \
sudo cp /etc/kolla/admin-openrc.sh /home/`whoami`/
sudo chown `whoami`:`whoami` /home/`whoami`/admin-openrc.sh
sudo yum -y install yum-versionlock && \
sudo yum versionlock docker && \
sudo yum versionlock docker-engine
```

## Ubuntu

```bash
echo "`whoami` ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/`whoami`
sudo apt install -y python-pip      \
                    python-devel    \
                    libffi-devel    \
                    gcc             \
                    libssl-devel    \
                    ntp             \
                    python-selinux
sudo systemctl enable ntpd.service
sudo systemctl start ntpd.service
#sudo pip install -U pip
sudo pip install -U kolla-ansible ansible
sudo cp -r /usr/local/share/kolla-ansible/etc_examples/kolla /etc/
sudo cp /usr/local/share/kolla-ansible/ansible/inventory/* /home/`whoami`/
pvcreate /dev/vdb
vgcreate cinder-volumes /dev/vdb
sudo sed -i 's/#config_strategy: "COPY_ALWAYS"/config_strategy: "COPY_ALWAYS"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#kolla_base_distro: "centos"/kolla_base_distro: "centos"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#kolla_install_type: "binary"/kolla_install_type: "binary"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#openstack_release: ""/openstack_release: "pike"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#network_interface: "eth0"/network_interface: "eth1"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#neutron_external_interface: "eth1"/neutron_external_interface: "eth2"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#enable_heat: "yes"/enable_heat: "yes"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#enable_grafana: "no"/enable_grafana: "yes"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#enable_horizon: "yes"/enable_horizon: "yes"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#enable_horizon_neutron_lbaas: "{{ enable_neutron_lbaas | bool }}"/enable_horizon_neutron_lbaas: "{{ enable_neutron_lbaas | bool }}"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#enable_central_logging: "no"/enable_central_logging: "yes"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#enable_magnum: "no"/enable_magnum: "yes"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#enable_neutron_lbaas: "no"/enable_neutron_lbaas: "yes"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#nova_compute_virt_type: "kvm"/nova_compute_virt_type: "kvm"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#enable_cinder: "no"/enable_cinder: "yes"/g' /etc/kolla/globals.yml && \
sudo sed -i 's/#enable_cinder_backend_lvm: "no"/enable_cinder_backend_lvm: "yes"/g' /etc/kolla/globals.yml && \
##sudo sed -i 's///g' /etc/kolla/globals.yml && \
sudo sed -i 's/10.10.10.254/192.168.1.120/g' /etc/kolla/globals.yml && \
sudo kolla-genpwd && \
sudo kolla-ansible -i /home/`whoami`/all-in-one bootstrap-servers && \
sudo kolla-ansible pull -i /home/`whoami`/all-in-one && \
sudo kolla-ansible -i /home/`whoami`/all-in-one prechecks && \
sudo kolla-ansible -i /home/`whoami`/all-in-one deploy && \
sudo kolla-ansible -i /home/`whoami`/all-in-one post-deploy && \
sudo cp /etc/kolla/admin-openrc.sh /home/`whoami`/
sudo chown `whoami`:`whoami` /home/`whoami`/admin-openrc.sh
```
