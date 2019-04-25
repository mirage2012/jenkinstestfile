#!/usr/bin/env bash
curl -X POST -u ${DEVOPS_ELASTIC_USER}:${DEVOPS_ELASTIC_PASS} "${DEVOPS_ELASTIC}/_security/role/cmp.devops.user.upi" -H 'Content-Type: application/json' -d'
{
  "cluster" : [
  ],
  "indices" : [
  ],
  "applications" : [
    {
      "application" : "kibana-.kibana",
      "privileges" : [
        "read"
      ],
      "resources" : [
        "*"
      ]
    },
    {
      "application" : "kibana-.kibana",
      "privileges" : [
        "space_all"
      ],
      "resources" : [
        "space:upi"
      ]
    }
  ]
}
'
