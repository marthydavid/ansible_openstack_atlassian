#!/bin/bash
source ~/keystonerc_demo
/usr/bin/ansible-playbook create_start_stop.yml -e "create=1"
