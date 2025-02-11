# About this Project
CISL deployed an on-premise cloud environment for compute and storage.

## On-premise cloud

An on-premise (on-prem) cloud consists of storage, compute, and networking resources hosted on fully redundant hardware installed in personal/organizational facilities available to users 

### Kubernetes (K8s)
We utilize a K8s cluster to host JupyterHub. Dask Gateway is installed to enable parallel computing. A JupyterHub Spawner creates single user environments with access to a shared and personal storage space. The Spawned user environments come in different sizes with GPU options. 

K8s can be used to host containers for individual use cases.

#### JupyterHub on K8s
There is a JupyterHub instance hosted on the K8s cluster. This JupyterHub has customized container images that enable packages, kernels, and extensions the scientific research community utilizes to increase productivity in data analysis. The custom environment also provides users read-only access to the campaign directory on GLAD. Access to the JupyterHub is handled via GitHub authentication and a team under the NCAR organization in GitHub. 

### Storage
#### GLADE
NFS is utilized to provide RO only access to GLADE on the Spawned JupyterHub user environments. Currently the campaign directory on GLADE is available as read only.  

#### STRATUS
S3 is be provided via CISLs object storage platform [STRATUS](https://arc.ucar.edu/knowledge_base/70549594). 

## Data Access
[AWS S3 Open Data Registry](https://registry.opendata.aws/) utilizes AWS S3 API calls the same way as STRATUS. By utilizing S3 API calls we can make Data accessible in a familiar way on the Web and on-premise. 

## Agile Program Management
**[Kanban Board](https://jira.ucar.edu/secure/RapidBoard.jspa?rapidView=220&projectKey=CCPP)**

This project implements a hybrid Agile Project Management workflow. Waterfall techniques are used for high level project management. Kanban is used for day to day tasks and creating a continuous flow of value to users. 