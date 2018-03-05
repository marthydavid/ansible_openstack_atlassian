# Install Steps

```bash
echo "`whoami` ALL=(ALL) NOPASSWD:ALL"| sudo tee /etc/sudoers.d/`whoami`
sudo yum update -y && sudo yum install -y tmux vim
printf "LANG=en_US.utf-8\nLC_ALL=en_US.utf-8" | sudo tee /etc/environment
sudo -i
systemctl disable firewalld
systemctl stop firewalld
systemctl disable NetworkManager
systemctl stop NetworkManager
systemctl enable network
systemctl start network
yum install -y epel-release
yum install -y yum-utils
yum install -y centos-release-openstack-pike
yum-config-manager --enable openstack-pike
yum update -y 
yum install -y openstack-packstack
packstack --gen-answer-file=allinone-nat.cfg
sed -i -e 's/CONFIG_DEFAULT_PASSWORD=/CONFIG_DEFAULT_PASSWORD=Almafa12/g' allinone-nat.cfg
sed -i -e 's/CONFIG_NTP_SERVERS=/CCONFIG_NTP_SERVERS=0.rhel.pool.ntp.org,1.rhel.pool.ntp.org/g' allinone-nat.cfg
sed -i -e 's/CONFIG_NEUTRON_OVS_BRIDGE_IFACES=/CONFIG_NEUTRON_OVS_BRIDGE_IFACES=br-ex:eth0/g' allinone-nat.cfg
sed -i -e 's/CONFIG_PROVISION_DEMO=y/CONFIG_PROVISION_DEMO=n/g' allinone-nat.cfg
time packstack --answer-file=allinone-nat.cfg
```

## After Installation

```bash
. ~/keystonerc_admin
neutron net-create external_network --provider:network_type flat --provider:physical_network extnet  --router:external
neutron subnet-create --name public_subnet --enable_dhcp=False --allocation-pool=start=192.168.200.200,end=192.168.200.220 --gateway=192.168.200.1 external_network 192.168.200.0/24
curl http://download.cirros-cloud.net/0.3.4/cirros-0.3.4-x86_64-disk.img | glance image-create --name='cirros image' --visibility=public --container-format=bare --disk-format=qcow2
openstack project create --enable demo
openstack user create --project demo --password Almafa12 --email demo@localhost --enable demo
```

### At this stage you need to add manually the demo user to demo project from horizon with admin user
### after that you could move on in the same shell

```bash
export OS_USERNAME=demo
export OS_TENANT_NAME=demo
export OS_PASSWORD=Almafa12
neutron router-create router1
neutron router-gateway-set router1 external_network
neutron net-create private_network
neutron subnet-create --name private_subnet private_network --dns-nameserver 8.8.8.8 10.0.0.0/24
neutron router-interface-add router1 private_subnet
```
