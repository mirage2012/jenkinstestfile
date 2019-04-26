#!/usr/bin/env bash
set +e

curl -sX PUT -u ${ELASTIC_USR}:${ELASTIC_PSW} "${DEVOPS_ELASTIC}:${ELASTIC_PORT}/_template/template_1" -H 'Content-Type: application/json' -d '
{
  	"index_patterns": ["*.kube*"],

  	"mappings": {
  		"fluentd": {
  			"properties": {
  				"kubernetes": {
  					"properties": {
  						"container_name": {
  							"type": "keyword"
  						},
                        "host" : {
                            "type": "keyword"
                        },
                        "labels" : {
                            "type": "keyword"
                        },
                        "env" : {
                            "type": "keyword"
                        },
                        "envtype" : {
                            "type": "keyword"
                        },
                        "pod-template-hash" : {
                            "type": "keyword"
                        },
                        "release" : {
                            "type": "keyword"
                        },
                        "master_url" : {
                            "type": "keyword"
                        },
                        "namespace_id" : {
                            "type": "keyword"
                        },
                        "namespace_labels" : {
                            "type": "keyword"
                        },
                        "namespace_name" : {
                            "type": "keyword"
                        },
                        "pod_id" : {
                            "type": "keyword"
                        },
                        "pod_name" : {
                            "type": "keyword"
                        }

                                
  					}
  				}
  			}
  		}
  	}
  }
'


