# Create an OSEv3 group that contains the masters, nodes, and etcd groups
[OSEv3:children]
masters
nodes
etcd

# Set variables common for all OSEv3 hosts
[OSEv3:vars]
# SSH user, this user should allow ssh based auth without requiring a password
ansible_ssh_user=jkelly
# If ansible_ssh_user is not root, ansible_become must be set to true
ansible_become=true

openshift_deployment_type=origin
#openshift_master_default_subdomain=apps.local
openshift_master_default_subdomain=app.cavenet.ca
os_firewall_use_firewalld=true

# uncomment the following to enable htpasswd authentication; defaults to DenyAllPasswordIdentityProvider
openshift_master_identity_providers=[{'name': 'htpasswd_auth', 'login': 'true', 'challenge': 'true', 'kind': 'HTPasswdPasswordIdentityProvider', 'filename': '/etc/origin/master/htpasswd'}]
openshift_master_htpasswd_file=/home/jkelly/mission/ansible/htpasswd

openshift_docker_options="--log-driver json-file --log-opt max-size=1M --log-opt max-file=3"
openshift_check_min_host_memory_gb=1.5
openshift_check_min_host_disk_gb=15


# host group for masters
[masters]
mm01.cavenet.ca

# host group for etcd
[etcd]
mm01.cavenet.ca

# host group for nodes, includes region info
[nodes]
mm01.cavenet.ca openshift_node_labels="{'region': 'infra','zone': 'default'}" openshift_schedulable=true
mnode01.cavenet.ca openshift_node_labels="{'region': 'primary', 'zone': 'default'}"
mnode02.cavenet.ca openshift_node_labels="{'region': 'primary', 'zone': 'default'}"
#mnode03.cavenet.ca openshift_node_labels="{'region': 'infra', 'zone': 'default'}"
