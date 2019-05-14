#!/usr/bin/env python3
import requests
import os
import json


def role_payload(val):
    """
    Content needed for creating elasticsearch role.
    :param val: val is name of team that need onboarding.
    :return: returns payload for role
    """
    payload_role = {
        "cluster": [],
        "indices": [{
            "names": (
                "log-{}*".format(val),
                "log.{}*".format(val)
            ),
            "privileges": [
                "read"
            ],
            "field_security": {
                "grant": [
                    "*"
                ]
            }
        }],
        "applications": [{
            "application": "kibana-.kibana",
            "privileges": [
                "read"
            ],
            "resources": [
                "*"
            ]
        },
            {
                "application": "kibana-.kibana",
                "privileges": [
                    "space_all"
                ],
                "resources": [
                    "space:{}".format(val)
                ]
            }
        ]
    }

    return payload_role


def mapping_payload(val):
    """
    Content needed for creating elasticsearch role.
    :param val: val is name of team that need onboarding
    :return: returns payload for mapping
    """
    payload_mapping = {
        "enabled": "true",
        "roles": [
            "cmp.devops.user.{}".format(val)
        ],
        "rules": {
            "field": {
                "groups": "cmp.devops.user.{}".format(val)
            }
        },
        "metadata": {
            "version": 1
        }
    }

    return payload_mapping


def elastic(val):
    """
     Use the json content to create the role and role_mapping in elastic search.
    :param val: val is name of team that need onboarding.

    """
    url_role = os.environ.get("DEVOPS_ELASTIC") + ":" + os.environ.get(
        "ELASTIC_PORT") + "/_xpack/security/role/cmp.devops.user.{}".format(val)
    response_role = requests.post(url_role, auth=(os.environ.get("ELASTIC_USR"), os.environ.get("ELASTIC_PSW")),
                                  headers={"content-type": "application/json"}, data=json.dumps(role_payload(val)))
    res_role = response_role.json()
    print("Creating Role for team {}".format(val), res_role)

    url_mapping = os.environ.get("DEVOPS_ELASTIC") + ":" + os.environ.get(
        "ELASTIC_PORT") + "/_xpack/security/role_mapping/cmp.devops.user.{}".format(val)
    response_mapping = requests.put(url_mapping, auth=(os.environ.get("ELASTIC_USR"), os.environ.get("ELASTIC_PSW")),
                                    headers={"content-type": "application/json"}, data=json.dumps(mapping_payload(val)))
    res_mapping = response_mapping.json()
    print("Creatting role_mapping for team {}".format(val), res_mapping)


for team in ["impst", "asasas"]:
    elastic(team)
    
    
