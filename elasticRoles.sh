#!/usr/bin/env bash
# Declare an array of string with type
declare -a Teams=("iot" "devops-data" )
# Create an elasticsearch Role
for val in ${Teams[@]}; do
   curl -X POST -u ${ELASTIC_USR}:${ELASTIC_PSW} "${DEVOPS_ELASTIC}:${ELASTIC_PORT}/_xpack/security/role/cmp.devops.user.$val" -H 'Content-Type: application/json' -d '
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
printf -- '-%.0s' {1..100}; echo ""
#Create Roll mappings for the above roles

curl -X PUT -u ${ELASTIC_USR}:${ELASTIC_PSW} "${DEVOPS_ELASTIC}:${ELASTIC_PORT}/_xpack/security/role_mapping/cmp.devops.user.$val" -H 'Content-Type: application/json' -d'
{
 "enabled" : true,
 "roles" : [
    "cmp.devops.user.'$val'"
 ],
 "rules" : {
    "field" : {
    "groups" : "cmp.devops.user.'$val'"
    }
 },
 "metadata" : {
    "version" : 1
    }
 }
'
printf -- '-%.0s' {1..100}; echo ""done

