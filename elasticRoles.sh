#!/usr/bin/env bash
curl -X POST -u ${ELASTIC_USR}:${ELASTIC_PSW} "${DEVOPS_ELASTIC}:${ELASTIC_PORT}/_security/role/cmp.devops.user.upi" -H 'Content-Type: application/json' -d'
{
  "cluster" : [
  ],
  "indices" : [
      {
        "names" : [
          "log-upi*",
          "log.upi*"
        ],
        "privileges" : [
          "read"
        ],
        "field_security" : {
          "grant" : [
            "*"
          ]
        }
      }
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
