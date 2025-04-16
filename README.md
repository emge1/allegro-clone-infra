# Overview

Allegro Clone is a demo implementation of a popular Polish e-commerce platform, similar to Amazon. This repository 
aims to provide the necessary cloud resources, networking, and deployment automation to support the entire system, 
ensuring a scalable and consistent infrastructure across all environments, including local, development, and production.

While the infrastructure is under active development, both the [API](https://github.com/emge1/allegro-clone-api)
 and [UI](https://github.com/emge1/allegro-clone-frontend) parts are fully implemented.

# Table of contents
* [Architecture](#architecture)
* [Containerization (Docker)](#containerization--docker-)
  * [Final image sizes](#final-image-sizes-)
  * [Security & Scalability](#security--scalability)
* [Continuous Integration (GitHub Actions)](#continuous-integration--github-actions-)
  * [Security & Reliability](#security--reliability)
* [Continuous Deployment  (GitHub Actions)](#continuous-deployment--github-actions-)
  * [Security & Reliability (planned)](#security--reliability--planned-)
* [Orchestration (Kubernetes & Helm)](#orchestration--kubernetes--helm-)
  * [Security & Scalability (in progress)](#security--scalability--in-progress-)
* [Infrastructure (Terraform & AWS)](#infrastructure--terraform--aws-)
  * [Security & Networking (in progress)](#security--networking--in-progress-)
* [Monitoring & Logging](#monitoring--logging)
  * [Security & Scalability (planned)](#security--scalability--planned-)


# Architecture



# Containerization (Docker)
Application components ([API](https://github.com/emge1/allegro-clone-api)
& [UI](https://github.com/emge1/allegro-clone-frontend)) are containerized using Docker. Dockerfiles were optimized for performance, size, and security using the following techniques:

- **Multi-stage builds**: separating builder and runtime stages to reduce image size and attack surface  
- **Layered copy strategy**: placing frequently changed files later in the build to maximize Docker layer caching  
- **Lightweight base images**: using `slim` variants for backend (easier debugging) and `alpine` for frontend runtime  
- **.dockerignore**: to exclude unnecessary or sensitive files from being included in the build context

## Final image sizes:
- API: **~265 MB** (including sample data)
- UI: **~50 MB**

## Security & Scalability

- Defined `HEALTHCHECK` instructions for container readiness
- Running containers as a non-root user
- `.dockerignore` ensures no secrets or unneeded files are copied into the image

# Continuous Integration (GitHub Actions)
Continuous Integration is handled via GitHub Actions. Pipelines are defined within their respective repositories
([API](https://github.com/emge1/allegro-clone-api), [UI](https://github.com/emge1/allegro-clone-frontend))
triggered on push and pull request events for main branch.

The CI workflow includes:

- **Linting** (*in progress*)  
- **Unit & integration tests** within Dockerized environments  
- **Docker image build & vulnerability scanning** using Trivy
- **Publishing images to DockerHub**
- **Tagged releases** for versioned production artifacts

## Security & Reliability

- Secrets are injected via GitHub Actions secrets
- Scanning Docker images with Trivy
- Branch-based triggers for running workflows
- Tag-based triggers for pushing images to DockerHub

# Continuous Deployment (GitHub Actions)
Separate pipelines will be defined in the respective service repositories to manage deployments across environments.

The **intended** CD process includes:
- **Environment-specific deployments** (dev/staging/prod)  
- **Tagged release triggers**  
- **Helm-based deployments** to Kubernetes clusters for backend services  
- **Static file delivery** to AWS S3 for the UI in production
- Plans for **blue-green or canary deployments** to reduce risk during production rollouts

## Security & Reliability (Planned)

- Secrets to be handled via GitHub Actions environments and encrypted secrets  
- Tag- and environment-based gating for deployment control  
- Manual approvals before production deployments  
- Post-deployment health checks and rollback steps

# Orchestration (Kubernetes & Helm)
Application components are orchestrated using Kubernetes, with Helm charts managing deployment configuration, templating, and environment separation.

Key features:
- **Helm-based deployment** for API (custom chart)  
- Environment-specific values files (dev/staging/prod, *planned*)
- Dev environment uses in-cluster PostgreSQL and UI *(planned)*  
- **Ingress Controller** integrated with AWS ALB *(planned)*
- Monitoring components (Prometheus & Grafana) deployed via Helm *(planned)*  
- Logging stack using Loki *(planned)* 
- OpenSearch planned for centralized log storage *(planned)*

## Security & Scalability (in progress)

- API deployed with **readiness/liveness probes**  
- Containers run with **non-root users**  
- K8s **RBAC policies and ServiceAccounts** for access isolation *(planned)*  
- **Namespaces** for environment separation *(planned)*  
- **Resource requests & limits** to control consumption *(planned)*  
- **Horizontal Pod Autoscaler** for API *(planned)*  
- TLS termination via AWS ALB with cert-manager *(planned)*  
- NetworkPolicies to restrict internal traffic *(planned)*

# Infrastructure (Terraform & AWS)
The current infrastructure setup was initially designed without Kubernetes in mind and is now being refactored to support a more production-grade environment with EKS and a cloud-native approach.

This infrastructure setup focuses on the **production environment**.

Key features (*in progress*):

- **Terraform workflow** triggered only under specific conditions (tags), with optional manual approvals (**Continuous Delivery**)
- **IAM roles and policies** managed as code  
- **VPC, subnets, and security groups** defined via Terraform 
- **Subnet layout**:
  - public subnets for ALB  
  - private subnets for API and RDS
- **S3**:
  - backend for Terraform state *(planned: S3 with DynamoDB locking)*  
  - production hosting for the frontend (UI build)  
- **RDS** (Postgres) as the production database  
- **Application Load Balancer (ALB)** as entrypoint for external traffic, integrated with K8s Ingress   

Moreover, plans also include introducing Ansible and Vagrant for managing local development environments more consistently.

## Security & Networking (in progress)
- Secrets are planned to be managed via **AWS Secrets Manager**, with potential integration into the application or Kubernetes via environment variables  
- SSL certificates managed by **AWS Certificate Manager (ACM)**, attached to ALB and (optionally) CloudFront  
- **CloudFront** *(planned)* for UI delivery from S3 — independent from ALB (serves static content)  
- **DNS management** *(planned)* via **Route 53**, for domain configuration and routing to ALB or CloudFront

# Monitoring & Logging
Monitoring and logging are **planned**, with some tooling already deployed but not yet actively configured or used.

Key features (*planned*)
- **Prometheus**, **Grafana**, and **Loki** deployed via Helm  
- Alerting rules & integration with Alertmanager
- Logs collected from API pods  
- OpenSearch integration for long-term log storage  
- Golden signal metrics:
  - latency
  - traffic
  - errors
  - saturation

## Security & Scalability (planned)

- Secure access to Grafana via ingress/auth  
- Limited data retention and log cleanup  
- Internal-only metrics scraping  
- Alert routing and user access control