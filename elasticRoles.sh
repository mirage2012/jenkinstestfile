#!/usr/bin/env bash
curl -X POST -u ${ELASTIC_USR}:${} "${ELASTIC_PSW}/_security/role/cmp.devops.user.upi" -H 'Content-Type: application/json' -d'
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
