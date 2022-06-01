#!/usr/bin/env bash

# Example: go-vultr load-balancer get FOO
#
# ID              12345678-90ab-cdef-1234-567890abcdef
# DATE CREATED    2022-01-01T00:00:00+00:00
# REGION          sea
# LABEL           ae7c88ce1f34c4da8be8323c03c9c2ee
# STATUS          active
# IPV4            255.255.255.255
# IPV6            2001:19f0:8001:1076:ffff:ffff:ffff:ffff
# HAS SSL         false
# INSTANCES       [12345678-90ab-cdef-1234-567890abcdef,12345678-90ab-cdef-1234-567890abcdef]

# HEALTH CHECKS
# PROTOCOL        PORT    PATH    CHECK INTERVAL  RESPONSE TIMEOUT        UNHEALTHY THRESHOLD     HEALTHY THRESHOLD
# tcp             32674           15              5                       5                       5

# GENERIC INFO
# BALANCING ALGORITHM     SSL REDIRECT    COOKIE NAME     PROXY PROTOCOL  PRIVATE NETWORK
# roundrobin              false                           false           

# FORWARDING RULES
# RULEID                  FRONTEND PROTOCOL       FRONTEND PORT   BACKEND PROTOCOL        BACKEND PORT
# 123456789abcdef0        tcp                     50051           tcp                     33333

# FIREWALL RULES
# RULEID  PORT    SOURCE  IP_TYPE
# -       -       -

# Underscores (_) are used for values that can be ignored such as field names e.g. ID
# When the field name is multiple words e.g. DATE CREATED, two underscores are needed to read both key words
read _ ID
read _ _ DATE_CREATED
read _ REGION
read _ LABEL
read _ STATUS
read _ IPV4
read _ IPV6
read _ _ HAS_SSL
read _ INSTANCES
read _ # BLANK
read _ # HEALTH CHECKS
read _ # LABELS
read VALUES
read _ # BLANK

# Post-process INSTANCES
# JSON requires each string to be quoted
# f[foo,bar]=["foo","bar"]


# Replace any , with ","
INSTANCES=${INSTANCES/"["/"[\""}
# Replace ] with "]
INSTANCES=${INSTANCES/"]"/"\"]"}
# Replace [ with ["
INSTANCES=${INSTANCES/","/"\",\""}
# Handles if there are no instances ([""] should be [])
INSTANCES=${INSTANCES/"\"\""/""}

echo "{
    \"id\": \"${ID}\",
    \"date_created\": \"${DATE_CREATED}\",
    \"region\": \"${REGION}\",
    \"label\": \"${LABEL}\",
    \"status\": \"${STATUS}\",
    \"ipv4\": \"${IPV4}\",
    \"ipv6\": \"${IPV6}\",
    \"has_ssl\": \"${HAS_SSL}\",
    \"instances\": ${INSTANCES}
}"
