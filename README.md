# Mission-01

Learning how to Deploy OpenShift Origin for the first time.

## Initial Deployment

The deployment chosen for today is a 3-node cluster hosted on a single ESXi host.

### VM Deploy and Configure

Specs:
 - 4 RedHat VM's:
   - 1 x 2G RAM, 2 vCPU, 20GB Thin Provisioned storage
   - 3 x 2G RAM, 1 vCPU, 20GB Thin Provisioned storage (ended up only using 2)

Split DNS (internal as well as external DNS)
Static Leases for hosts via existing DHCP service

Each VM built with Minimal CentOS image
 - root and user (admin) accounts provisioned during install
 - mm01, mnode01, mnode02, mnode03 in the cavenet.ca domain for hostnames

Package and configuration customizations applied via ansible (Mission-01/EnvDeploy/deployOS.yml)

### OpenShift Deployment

Use the Advanced Installation (Ansible) scripts and configuration steps with some key additions to the ansible host configuration:
- openshift_master_default_subdomain=app.cavenet.ca
- os_firewall_use_firewalld=true

Very important to set the following to override the default minimum requirements!
- openshift_check_min_host_memory_gb=1.5
- openshift_check_min_host_disk_gb=15

See the actual hosts.OS file for a full picture of the additional options, but the above were the main requirements.

### TroubleShooting Fun
Adding extra infrastructure node may seem like a fun idea, but it adds to the network complexity when configuring gateways, DNS, etc.

Firewalls, port-forwarding, provider port blocking, and other networking fun when hosting presentation material from home.

VM Snapshots are awesome, but full deploy automation is better!

## Application Deployments

You can log into the OpenShift console at: https://mm01.cavenet.ca:8443/ and can view the my-project (very original) with 3 applications deployed.

### Simple Openshift Block
http://blog-myproject.app.cavenet.ca/ (or http://blog-myproject.app.cavenet.ca:9080/ for remote access)

### GoGs Repository
http://gogs-np.app.cavenet.ca/ (or http://gogs-np.app.cavenet.ca:9443/ for remote access)
- demo/demo
- Sourced from: https://github.com/OpenShiftDemos/gogs-openshift-docker

### Graphana
http://graphana.app.cavenet.ca/ (or http://graphana.app.cavenet.ca:9443/ for remote access)
- Sourced from: http://widerin.net/blog/official-grafana-docker-image-on-openshift/
