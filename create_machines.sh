#!/bin/bash

/usr/bin/ansible-playbook all -i ./openstack.py main.yml -e "create=1" --limit="localhost"