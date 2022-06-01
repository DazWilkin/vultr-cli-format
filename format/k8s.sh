#!/usr/bin/env bash

# ID              12345678-90ab-cdef-1234-567890abcdef
# LABEL           test
# DATE CREATED    2022-01-01T00:00:00+00:00
# CLUSTER SUBNET  255.255.255.255/16
# SERVICE SUBNET  255.255.255.255/12
# IP              255.255.255.255
# ENDPOINT        12345678-90ab-cdef-1234-567890abcdef.vultr-k8s.com
# VERSION         v1.23.5+3
# REGION          sea
# STATUS          pending
 
# NODE POOLS
# ID              12345678-90ab-cdef-1234-567890abcdef
# DATE CREATED    2022-01-01T00:00:00+00:00
# DATE UPDATED    2022-01-01T00:00:00+00:00
# LABEL           nodepool
# TAG             foo
# PLAN            vc2-1c-2gb
# STATUS          pending
# NODE QUANTITY   1
# AUTO SCALER     false
# MIN NODES       1
# MAX NODES       1
 
# NODES
# ID                                      DATE CREATED                    LABEL                   STATUS
# 699b7603-

# Underscores (_) are used for values that can be ignored such as field names e.g. ID
# When the field name is multiple words e.g. DATE CREATED, two underscores are needed to read both key words
read _ ID
read _ LABEL
read _ _ DATE_CREATED
read _ _ CLUSTER_SUBNET
read _ _ SERVICE_SUBNET
read _ IP
read _ ENDPOINT
read _ VERSION
read _ REGION
read _ STATUS
read _ # BLANK
read _ # NODE POOLS
read _ NP_ID
read _ _ NP_DATE_CREATED
read _ _ NP_DATE_UPDATED
read _ NP_LABEL
read _ NP_TAG
read _ NP_PLAN
read _ NP_STATUS
read _ _ NP_NODE_QUANTITY
read _ _ NP_AUTO_SCALERY
read _ _ NP_MIN_NODES
read _ _ NP_MAX_NODES
read _ # BLANK
read _ # NODES

echo "{
    \"id\": \"${ID}\",
    \"label\": \"${LABEL}\",
    \"date_created\": \"${DATE_CREATED}\",
    \"cluster_subnet\": \"${CLUSTER_SUBNET}\",
    \"service_subnet\": \"${SERVICE_SUBNET}\",
    \"ip\": \"${IP}\",
    \"endpoint\": \"${ENDPOINT}\",
    \"version\": \"${VERSION}\",
    \"region\": \"${REGION}\",
    \"status\": \"${STATUS}\",
    \"node_pools\":[
        {
            \"id\": \"${NP_ID}\",
            \"date_created\": \"${NP_DATE_CREATED}\",
            \"date_updated\": \"${NP_DATE_UPDATED}\",
            \"label\": \"${NP_LABEL}\",
            \"tag\": \"${NP_TAG}\",
            \"plan\": \"${NP_PLAN}\"
        }
    ]
}"