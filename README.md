# Install and configure the Elastic Stack

Install and configure the Elastic Stack:

* [elasticsearch](https://www.elastic.co/elasticsearch/)
* [logstash](https://www.elastic.co/logstash/)
* [kibana](https://www.elastic.co/kibana/)

Elastic Beats:

* [filebeat](https://www.elastic.co/beats/filebeat)
* [metricbeat](https://www.elastic.co/beats/metricbeat)
* [heartbeath](https://www.elastic.co/beats/heartbeat)

## Requirements

Install ipaddr and netaddr:

```
pip3 install -r requirements.txt
```

## Roles documentation

You can refer to the README.md file in each role directory:

* [elasticsearch](roles/elasticsearch/)
* [kibana](roles/kibana/)
* [logstash](roles/logstash/)
* [beats](roles/beats/)

you can also explore all roles variables [here](docs/ROLES_VARS.md)

## Ansible setup and pre-flight check

Make sure ansible is present in your machine along with python dependices in requirements.ext

With Ansible and the collection installed we can setup our inventory file (hosts.ini):

```
[elasticsearch_master]
elk-node-01 ansible_host=172.25.25.74 ansible_user=root
elk-node-02 ansible_host=172.25.25.164 ansible_user=root
elk-node-03 ansible_host=172.25.25.224 ansible_user=root

[elasticsearch_data]
elk-node-04 ansible_host=172.25.25.198 ansible_user=root
elk-node-05 ansible_host=172.25.25.225 ansible_user=root
elk-node-06 ansible_host=172.25.25.168 ansible_user=root

[elasticsearch_ca]
elk-node-01 ansible_host=172.25.25.74 ansible_user=root

[kibana]
elk-node-02 ansible_host=172.25.25.164 ansible_user=root

[logstash]
elk-node-06 ansible_host=172.25.25.168 ansible_user=root
elk-node-07 ansible_host=172.25.25.252 ansible_user=root

[elasticsearch:children]
elasticsearch_master
elasticsearch_data
```

and the vars.yml file:

```
---
elasticsearch_version: 8.11.3
kibana_version: 8.11.3
logstash_version: 8.11.3
beats_version: 8.11.3

elasticsearch_resolv_mode: hosts
elasticsearch_install_mode: local
elasticsearch_local_tar_path: ~/elk_tar_path
elasticsearch_monitoring_enabled: yes
elasticsearch_master_is_also_data_node: no

kibana_install_mode: local
kibana_local_tar_path: ~/elk_tar_path
setup_kibana_dashboards: yes
kibana_url: http://elk-node-02:5601

heartbeat_number_of_shards: 3
heartbeat_number_of_replicas: 3

metricbeat_number_of_shards: 3
metricbeat_number_of_replicas: 3

filebeat_number_of_shards: 3
filebeat_number_of_replicas: 3

elasticsearch_hosts:
  - elk-node-01 
  - elk-node-02
  - elk-node-03
  - elk-node-04
  - elk-node-05
  - elk-node-06
  - elk-node-07
```


The final cluster will be made of:

* 7 elasticsearch nodes (3 master nodes and 3 data nodes)
* 2 logstash instances
* 1 kibana  instances

To preserve bandwidth we download elasticsearch and kibana on our Ansible machine:

```
mkdir -p ~/elk_tar_path # <- you can customize this path by changing elasticsearch_local_tar_path variable
curl  -o ~/elk_tar_path/kibana-8.11.3-linux-x86_64.tar.gz https://artifacts.elastic.co/downloads/kibana/kibana-8.11.3-linux-x86_64.tar.gz
curl  -o ~/elk_tar_path/elasticsearch-8.11.3-linux-x86_64.tar.gz https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.11.3-linux-x86_64.tar.gz
curl  -o ~/elk_tar_path/logstash-8.11.3-linux-x86_64.tar.gz https://artifacts.elastic.co/downloads/logstash/logstash-8.11.3-linux-x86_64.tar.gz 

```

and we have to create the certificate directory, where elastic certificates will be stored:

```
mkdir -p ~/very_secure_dir
```

The final step before proceed with the installation is to create the site.yml file:

```
---
- hosts: elasticsearch
  become: yes
  remote_user: root
  collections:
    - elkstack.ansible_collection_elk
  vars_files:
    - vars.yml

  tasks:
    - import_role:
        name: elasticsearch

- hosts: kibana 
  become: yes
  remote_user: root
  collections:
    - elkstack.ansible_collection_elk
  vars_files:
    - vars.yml

  tasks:
    - import_role:
        name: kibana

- hosts: logstash 
  become: yes
  remote_user: root
  collections:
    - elkstack.ansible_collection_elk
  vars_files:
    - vars.yml

  tasks:
    - import_role:
        name: logstash

- hosts: elasticsearch 
  become: yes
  remote_user: root
  collections:
    - elkstack.ansible_collection_elk
  vars_files:
    - vars.yml

  tasks:
    - import_role:
        name: beats

```
Then finally install the collection by running the follwoing command

```ansible-playbook site.yaml -i inventory -e "generateca=yes"```

The CA will be downloaded from the cluster in the elasticsearch_local_certs_dir (defaults to ~/very_secure_dir). NOTE create the directory on the local machine before the Ansible run.

If you already have a CA, put the CA file in the elasticsearch_local_certs_dir and name the certificate with elasticsearch_ca_filename (defaults to elastic_ca.p12)
