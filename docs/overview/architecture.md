# Architecture

<img src="../../images/ml_nwsc_high_level.png"/>

# Explanation

All the CIRRUS infrastructure is deployed inside the NCAR network. Communication to external services is handled through a Load Balancer setup that utilizes BGP peering with network routers. 

<img src="../../images/nwsc_ml_cirrus_arch.png"/>

## Kubernetes

The control plane and worker nodes are all installed on bare metal systems. 

CIRRUS leverages [Kubernetes (K8s)](https://kubernetes.io/) to provide a Cloud native platform with shared services that are used to simplify deploying and hosting applications. It consists of control plane nodes hosted on bare metal running [K3s](https://k3s.io/) on [AlmaLinux](https://almalinux.org/). Worker nodes are SuperMicro SYS-120U-TNR servers running K3s on AlmaLinux. Services are currently hosted on 5 of these deployed at NWSC and 5 at ML.

### Hardware Resources

#### Compute Resources (5 Nodes at ML & NWSC)

| System Information | Node Specifications |
|---|---|
| Manufacturer | Supermicro |
| Model | SYS-120U-TNR | 
| CPU Type | Intel Xeon Gold 6326 |
| CPU Speed | 2.90 GHz |
| CPU Cores | 16 | 
| RAM (GB) | 512 |
| GPU Model | Nvidia A2 Tensor |
| GPU Cores | 1280 |
| GPU Memory | 16 GB |
| NICs | 2x10G & 4x25G |
| Storage | 2x100GB & 6x1.6TB NVMe |     

#### Totals

| CPU Cores | RAM | GPU Cores | GPU Mem | Local Storage |
|---|---|---|---|---|
| 80 | 2.5 TB | 6400 | 80 GB | 48 TB|

#### Storage Resources

| STRATUS | GLADE (RO) | NFS | LOCAL | 
|---|---|----|---|
| 3.3 PB | 38 PB | 110 TB | 48 TB |

## Helm charts

[Helm](https://helm.sh/) is utilized to apply application and service configurations. The chart files used on the cluster are stored in a public GitHub repository. Any sensitive information is encrypted with SOPS coupled with age. This provides administrators the ability to share complete charts that can be decrypted with their own unique key. 

## GPU Operator

The [NVIDIA GPU Operator](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/index.html) is configured and provides access to the worker node GPUs.

## Securely Exposing Services

[Nginx Ingress controller](https://docs.nginx.com/nginx-ingress-controller/) is configured to expose Services on the network. This is coupled with [ExternalDNS](https://bitnami.com/stack/external-dns/helm) to create resolvable DNS entries for the services deployed. [cert-manager](https://cert-manager.io/) assigns valid certificates to applications and performs lifecycle management on the issued certificates. This ensures all services are accessible only via HTTPS with valid certificates.   

## Storage Options

### Rook

[Rook](https://rook.io/docs/rook/v1.11/Getting-Started/intro/) is used to provide storage orchestration to K8s workloads. Rook utilizes Ceph as a distributed storage system to provide file, block, and object storage capabilities to the K8s cluster and the underlying objects hosted. 

#### GLADE Access

Read only access to data stored on GLADE is provided via NFS to the K8s nodes which is then exposed to objects in the cluster via Rook. 

### Stratus Object Storage

The [Stratus](https://arc.ucar.edu/knowledge_base/70549594) object storage system is for long term data storage and is provided by the [Advanced Research Computing](https://arc.ucar.edu/) division of NCAR | CISL

## Cluster Observability

Cluster resource observability and alerting is delivered via [Prometheus](https://prometheus.io/) and [Grafana](https://grafana.com/). Centralized persistent logging ties into the observability stack via [Loki](https://grafana.com/oss/loki/) and object storage provided by Rook. 

## Applications

### Harbor

[Harbor](https://goharbor.io/) is used to provide a container registry. This allows utilization of network infrastructure and available bandwidth between hardware for an increase in speed when pushing and pulling images locally. Popular public container registries are configured for Harbor to proxy pulls and cache public images locally. Harbor includes scanning via [trivy](https://trivy.dev/) and provides reports on vulnerabilities contained in an image so security concerns can be addressed. 

### JupyterHub

[JupyterHub](https://jupyter.org/hub) provides a way to spin up dedicated personal Jupyter Lab environments for users. We currently utilize GitHub authentication to control and provide access. Rook is utilized to add additional storage and mounts to the Jupyter user environments. The user environments are containerized versions of Jupyter Lab that are pulled from our internal container registry Harbor. 

### Binder

A separate instance of JupyterHub is coupled with [Binder](https://mybinder.org/) and Harbor enabling an endpoint for containerizing and hosting public notebooks via git. 

### Dask Gateway

[Dask](https://www.dask.org/) enables parallel computing in Python and offers options to create separate Dask clusters with dedicated resources. In the NCAR JupyterHub `dask_gateway` is utilized to provision a Dask [GatewayCluster](https://gateway.dask.org/api-client.html#gatewaycluster) via Python.

### ArgoCD

[Argo CD](https://argo-cd.readthedocs.io/en/stable/) is a continuous delivery application for Kubernetes. It is responsible for deploying and continuously monitoring running applications and comparing their live state with the desired state set in the associated Git repository.

### Web Applications

On top of the web applications already mentioned, CISL provides the ability to host additional containerized web applications on K8s. Using K8s to host these containerized workloads offers advantages when it comes to ensuring applications have valid TLS certificates, adding DNS A records for the application, and providing highly available and redundant compute resources. Some examples of the web applications users could host in the scientific space are Panel, Bokeh, HTML & JavaScript, and JupyterBook documentation to accompany them. 

## Virtual Machines

VMs are available by request for workloads that aren't appropriate for containers and K8s.
