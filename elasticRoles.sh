#!/usr/bin/env bash
set +e
if [ ${Cluster} == devone ]
then 
  username=${ELASTIC_USR}
  password=${ELASTIC_PSW}
elif [${Cluster} == devone ]  
then
  username=${ELASTIC_TST}
  password=${ELASTIC_TST}
 fi 

# Declare an array of string with type
declare -a Teams=("iot" "devops-data" )
# Create an elasticsearch Role
for val in ${Teams[@]}; do
 echo ""; printf -- '-%.0s' {1..100}; echo ""
 
 echo "Creating the Role $val" ; echo ""

   echo curl -sX POST -u ${username}:${password} "${DEVOPS_ELASTIC}:${ELASTIC_PORT}/_xpack/security/role/cmp.devops.user.$val" -H 'Content-Type: application/json' -d '
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
echo ""; echo "Creating role mapping for the Role $val"; echo ""
#Create Roll mappings for the above roles

echo curl -sX PUT -u ${ELASTIC_USR}:${ELASTIC_PSW} "${DEVOPS_ELASTIC}:${ELASTIC_PORT}/_xpack/security/role_mapping/cmp.devops.user.$val" -H 'Content-Type: application/json' -d'
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
echo ""; printf -- '-%.0s' {1..100}; echo ""
done
echo " We are all done!"
