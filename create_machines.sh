#!/bin/bash

/usr/bin/ansible-playbook main.yml -e "create=1" --limit="localhost"