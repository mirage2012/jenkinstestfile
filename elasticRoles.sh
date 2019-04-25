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
curl -X POST -u ${ELASTIC_USR}:${ELASTIC_PSW} "${DEVOPS_ELASTIC}:${ELASTIC_PORT}/_security/role/" -H 'Content-Type: application/json' -d'
{
"cmp.devops.user.devops-data" : {
    "cluster" : [ ],
    "indices" : [
      {
        "names" : [
          "edu*"
        ],
        "privileges" : [
          "read",
          "view_index_metadata"
        ],
        "field_security" : {
          "grant" : [
            "*"
          ]
        }
      },
      {
        "names" : [
          "stats*"
        ],
        "privileges" : [
          "all"
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
          "space:devops-data"
        ]
      }
    ],
    "run_as" : [ ],
    "metadata" : { },
    "transient_metadata" : {
      "enabled" : true
    }
  },
  "loris_ingest" : {
    "cluster" : [
      "monitor"
    ],
    "indices" : [
      {
        "names" : [
          "loris*"
        ],
        "privileges" : [
          "all"
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
          "space:nexxis"
        ]
      }
    ],
    "run_as" : [ ],
    "metadata" : { },
    "transient_metadata" : {
      "enabled" : true
    }
  }
  }
  '
