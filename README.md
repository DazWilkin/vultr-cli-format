# JSON formatting for `vultr-cli` commands<sup>1</sup>

> <sup>1</sup> Very few `vultr-cli` commands are supported (see: [Supported Commands](#support-commands))

Implements a <font style="color:green">very basic</font> form of `--output=json` formatting for [`vultr-cli`](https://github.com/vultr/vultr-cli)

`vultr-cli` is a comprehensive CLI for [Vultr](https://vultr.com) **but** it is challenging to use `vultr-cli` in scripts because command output is unstructured text, e.g.:

```
ID              12345678-90ab-cdef-1234-567890abcdef
LABEL           test
DATE CREATED    2022-01-01T00:00:00+00:00
CLUSTER SUBNET  255.255.255.255/16
SERVICE SUBNET  255.255.255.255/12
IP              255.255.255.255
ENDPOINT        12345678-90ab-cdef-1234-567890abcdef.vultr-k8s.com
VERSION         v1.23.5+3
REGION          sea
STATUS          pending
 
NODE POOLS
ID              12345678-90ab-cdef-1234-567890abcdef
DATE CREATED    2022-01-01T00:00:00+00:00
DATE UPDATED    2022-01-01T00:00:00+00:00
LABEL           nodepool
TAG             foo
PLAN            vc2-1c-2gb
STATUS          pending
NODE QUANTITY   1
AUTO SCALER     false
MIN NODES       1
MAX NODES       1
 
NODES
ID                                      DATE CREATED                    LABEL                   STATUS
12345678-
```

Immediately after running e.g. `vultr-cli kubernetes create`, a developer would want to e.g. `get` the cluster in order to poll its `STATUS` awaiting `active`.

To do this, the developer can either eyeball the output of the `create` command and copy-paste the `ID` or use ad hoc scripting tools to extract the `ID` value.

> **NOTE** There is a [`rewrite`](https://github.com/vultr/vultr-cli/tree/rewrite) branch of `vultr-cli` that includes a formal implementation of 

Commonly, CLI tools provide JSON and YAML output formatting as these facilitate such scripting.

This repo provides a basic (!) approach to this problem:

```bash
vultr-cli kubernetes create ... |\
./format/k8s.sh |\
jq -r 
```
Yields:


```JSON
{
  "id": "12345678-90ab-cdef-1234-567890abcdef",
  "label": "test",
  "date_created": "2022-01-01T00:00:00+00:00",
  "cluster_subnet": "255.255.255.255/16",
  "service_subnet": "255.255.255.255/12",
  "ip": "255.255.255.255",
  "endpoint": "12345678-90ab-cdef-1234-567890abcdef.vultr-k8s.com",
  "version": "v1.23.5+3",
  "region": "sea",
  "status": "pending",
  "node_pools": [
    {
      "id": "12345678-90ab-cdef-1234-567890abcdef",
      "date_created": "2022-01-01T00:00:00+00:00",
      "date_updated": "2022-01-01T00:00:00+00:00",
      "label": "nodepool",
      "tag": "foo",
      "plan": "vc2-1c-2gb"
    }
  ]
}
```

And so to retrieve just the cluster ID is trivial:

```bash
vultr-cli kubernetes create ... |\
./format/k8s.sh |\
jq -r .id
```


## Supported Commands

Currently supports a very limited subset of commands

|Command|Sub-command(s)|Script(s)|
|-------|--------------|---------|
|`kubernetes`|`create`, `get`|`format/k8s.sh`|
|`load-balancer`|`create`, `get`|`format/lb.sh`|


## Limitations

1. Limited set of commands supported (please contribute)
1. Limited set of command output supported e.g. Kubernetes multi-nodepools (ideas?)
1. Command output includes tables (e.g. Kubernetes Nodes) which aren't converted (ideas?)
