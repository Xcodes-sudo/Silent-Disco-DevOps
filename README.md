# Silent Disco DevOps - Event Website & Deployment Infrastructure

This repository demonstrates a complete DevOps lifecycle built around a Spring Boot Silent Disco event web application. It showcases a modern automated pipeline, containerization, local cluster orchestration, and unified monitoring, logging, and performance visualization metrics.

## Build Status

- ✅ Spring Boot Application
- ✅ Maven Build
- ✅ Jenkins CI/CD Pipeline
- ✅ Docker Containerization
- ✅ Kubernetes Deployment
- ✅ Nagios Monitoring
- ✅ Graphite Metrics Collection
- ✅ Grafana Dashboards

---

## Architecture Overview

```text
GitHub
    │
    ▼
Jenkins CI/CD
    │
    ▼
Maven Build
    │
    ▼
Docker Image
    │
    ▼
Kubernetes Cluster
    │
    ▼
Spring Boot Application
    │
    ├────────► Nagios
    │
    └────────► Graphite
                     │
                     ▼
                 Grafana
```

---

## Technology Stack

| Technology | Purpose | Version |
| :--- | :--- | :--- |
| **Java** | Programming Language & Runtime | 21 |
| **Spring Boot** | Embedded Web Server & Application Framework | 3.3.4 (Starter Web) |
| **Maven** | Dependency Management & Build Lifecycle | 3.x (Wrapper Integrated) |
| **Jenkins** | CI/CD Pipeline Automation | Pipeline Core |
| **Docker** | Containerization & Multi-Container Compose | Docker Desktop v20.x+ |
| **Kubernetes** | Container Orchestration | v1.36+ (Control Plane Node) |
| **Nagios** | Infrastructure Availability & Host Monitoring | Core v4.5.7 |
| **Graphite** | Time-series Metrics Ingestion & Carbon Cache | v1.1.10-4 |
| **Grafana** | Operational Dashboards & Visualization | v10.4.2 |
| **Git** | Distributed Version Control | Local Engine |
| **GitHub** | Remote Source Code Hosting | Repository |

---

## Features

- **Spring Boot Web Application**: Houses the static multi-page website (including registration, event info, and ticket confirmation) served at the root context directory via an embedded Apache Tomcat server.
- **Maven Build System**: Modular lifecycle management compiled and packaged cleanly utilizing portable Maven Wrapper commands.
- **Jenkins CI/CD Pipeline**: Scripted build automation pipeline validating checkout, compilation, unit tests, packaging, and archiving.
- **Docker Containerization**: Production-ready, multi-stage Docker builds separating the compilation environment (JDK 21) from the minimal execution environment (JRE 21) to optimize image size and security.
- **Kubernetes Deployment**: Orchestration configurations declaring dual replicas, liveness/readiness health probes, and a NodePort service mapping port 30080 on Docker Desktop's Kubernetes cluster.
- **Nagios Monitoring**: Proactive host and availability checks ensuring the cluster node and HTTP web app pages respond with code 200 OK.
- **Graphite Metrics Collection**: Carbon TCP/UDP line receivers collecting performance metrics and storing them in persistent Whisper time-series database directories.
- **Grafana Dashboards**: File-based auto-provisioned dashboards rendering live graphs for custom app clicks and internal system CPU metrics.
- **GitHub Version Control**: Standardized directory structure, exclusion definitions (.gitignore, .dockerignore), and pipeline configurations.

---

## Application Pages

- **Home**: Dark-themed interactive bento grid representing event channels, features, and social integration.
- **Event Information**: Detailed guide covering schedule times, location details, and channel details.
- **Registration**: Ticket reservation form validating client input and generating reservation IDs.
- **Confirmation**: Final ticket verification screen containing details, dynamic dates, and security codes.

---

## Project Structure

```text
Silent-Disco-DevOps/
├── .mvn/                             # Maven Wrapper properties and binaries
│   └── wrapper/
│       ├── maven-wrapper.jar
│       └── maven-wrapper.properties
├── src/
│   └── main/
│       ├── java/                     # Application source files
│       │   └── com/
│       │       └── silentdisco/
│       │           └── devops/
│       │               └── SilentDiscoApplication.java
│       └── resources/                # Configuration and static web assets
│           ├── application.properties
│           └── static/
│               ├── assets/           # Event images and visuals
│               │   ├── dj_cyan.png
│               │   ├── dj_magenta.png
│               │   └── dj_neon.png
│               ├── confirmation.html
│               ├── event-info.html
│               ├── index.html
│               ├── register.html
│               └── supabase.js       # Supabase client integration
├── nagios/
│   └── conf.d/
│       └── silent_disco.cfg          # Custom host and HTTP service definitions
├── grafana/
│   └── provisioning/
│       ├── datasources/
│       │   └── graphite.yaml         # Auto-provisioned Graphite data source
│       └── dashboards/
│           ├── dashboards.yaml       # Auto-provisioned dashboard providers
│           └── silent_disco.json     # Custom performance visualization JSON
├── Dockerfile                        # Multi-stage JRE 21 container definition
├── docker-compose.yml                # Nagios, Graphite, and Grafana deployment
├── Jenkinsfile                       # Multi-stage CI pipeline script
├── deployment.yaml                   # Kubernetes Deployment manifest
├── service.yaml                      # Kubernetes NodePort Service manifest
├── .dockerignore                     # Exclusions for container contexts
├── .gitignore                        # Exclusions for Git version control
├── mvnw                              # Unix Maven Wrapper script
├── mvnw.cmd                          # Windows Maven Wrapper script
└── pom.xml                           # Maven project configuration file
```

---

## Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/Xcodes-sudo/Silent-Disco-DevOps.git
cd Silent-Disco-DevOps
```

### 2. Build with Maven Wrapper
Compile the Java code and package it into an executable JAR file:
```cmd
# Windows
.\mvnw.cmd clean package

# macOS / Linux
chmod +x mvnw
./mvnw clean package
```

### 3. Run Locally
Start the Spring Boot Tomcat server locally on port 8080:
```cmd
# Windows
.\mvnw.cmd spring-boot:run

# macOS / Linux
./mvnw spring-boot:run
```
Access the application at [http://localhost:8080/](http://localhost:8080/).

### 4. Build and Run via Docker
Build the multi-stage Docker image and launch it on port 8081 (to avoid conflicts with Jenkins/8080):
```bash
# Build
docker build -t silent-disco-app:latest .

# Run
docker run -d --name silent-disco-container -p 8081:8080 silent-disco-app:latest
```
Access the application at [http://localhost:8081/](http://localhost:8081/).

### 5. Deploy to Kubernetes
Apply the deployment configuration to launch **2 replicas** managed by a Kubernetes Deployment and expose it via a NodePort Service:
```bash
# Deploy manifests
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

# Enable external access via port forwarding
kubectl port-forward service/silent-disco-service 30080:8080 --address 127.0.0.1
```
Access the Kubernetes deployment at [http://localhost:30080/](http://localhost:30080/).

### 6. Launch the Monitoring Stack
Bring up the Nagios, Graphite, and Grafana containers:
```bash
docker compose up -d
```
Verify the health and logs of the monitoring servers using:
```bash
docker compose ps
docker logs nagios-server
docker logs graphite-server
docker logs grafana-server
```

---

## CI/CD Pipeline

The `Jenkinsfile` configures a declarative pipeline containing the following core stages:

1. **Checkout**: Retrieves the latest application codebase from the repository.
2. **Clean Workspace**: Wipes any previous build artifacts to guarantee a clean compile.
3. **Build**: Runs `mvnw clean compile` to compile application classes.
4. **Test**: Executes unit test suites to prevent regression errors.
5. **Package**: Compiles and packages binaries into `target/devops-0.0.1-SNAPSHOT.jar`, skipping test runs for efficiency.
6. **Archive Artifacts**: Archives and stores the generated JAR file in Jenkins for release tracking.

---

## Monitoring Stack

The monitoring infrastructure consists of three interconnected systems:

- **Nagios (Port 8082)**: Validates uptime and availability. It queries the local network gateway and pings the Kubernetes NodePort IP. It continuously checks HTTP page responsiveness for `/`, `/index.html`, `/event-info.html`, `/register.html`, and `/confirmation.html`.
  - *URL*: [http://localhost:8082/nagios/](http://localhost:8082/nagios/) (Credentials: `nagiosadmin` / `nagiosadmin`)
- **Graphite (Port 8083)**: Handles time-series metric aggregation. It receives payloads via the Carbon TCP/UDP line receivers on port `2003` and persists metric databases under durable Whisper storage volumes.
  - *URL*: [http://localhost:8083/](http://localhost:8083/)
- **Grafana (Port 8084)**: Displays beautiful visual telemetry dashboards. It is pre-configured to query Graphite as its default datasource, plotting host resource statistics alongside custom application click-rate events.
  - *URL*: [http://localhost:8084/](http://localhost:8084/) (Credentials: `admin` / `admin`)

---

## Future Enhancements

- **Prometheus Integration**: Migrate from Carbon metrics to scrape native Spring Boot Actuator endpoints using a Prometheus collector.
- **Helm Charts**: Package Kubernetes manifests into structured Helm charts to support parameterized deployments across environments (Dev, Staging, Prod).
- **Kubernetes Ingress**: Replace NodePort mappings with an NGINX Ingress Controller and configure custom host domain routing.
- **Automated Deployment from Jenkins**: Extend the CI/CD pipeline to automatically rebuild Docker images and apply changes to Kubernetes using GitOps or trigger deployment scripts.
- **Production-Ready Monitoring**: Implement alert notifications via Slack or email notifications on Nagios/Grafana thresholds.
