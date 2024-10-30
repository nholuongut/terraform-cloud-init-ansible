#!/usr/bin/python
# Meant to replace the /etc/ansible/hosts script on hosts and allow for
# local environment & role based ansible runs.

import sys
import os
import json


def main():
    inventory = {"_meta": {"hostvars": {}}}
    inventory['base'] = ["127.0.0.1"]

    # Puts this host in the given HOSTGROUP
    try:
        host_role = os.environ.get("HOSTGROUP", 'default')
        inventory[host_role] = ["127.0.0.1"]
    except KeyError:
        pass

    try:
        host_env = os.environ.get('ENV', 'default')
        inventory[host_env] = ["127.0.0.1"]
    except KeyError:
        pass

    print json.dumps(inventory)

if __name__ == '__main__':
    sys.exit(main())
