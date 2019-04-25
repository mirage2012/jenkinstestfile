#!/usr/bin/env bash
# Declare an array of string with type
declare -a Teams=("iot" "devops-data" )
for val in ${Teams[@]}; do
   curl -X POST -u ${ELASTIC_USR}:${ELASTIC_PSW} "${DEVOPS_ELASTIC}:${ELASTIC_PORT}/_security/role/cmp.devops.user.$val" -H 'Content-Type: application/json' -d '
   {
  "cluster" : [
  ],
  "indices" : [
      {
        "names" : [
          "log-'$val'*",
          "log.'$val'*"
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
        "space:'$val'"
      ]
    }
  ]
}
'
done

