# Silent Disco DevOps - College Event Website

A Project based on a static multi-page website converted into a standardized Spring Boot Maven application running on Java 21. This project acts as the foundation for modern CI/CD, Containerization, Orchestration, and Monitoring practices.

## Project Overview
This repository contains a responsive, dark-themed **Silent Disco College Event Website**. Originally built as a static client-side web application integrating Supabase database client for user registrations, the application has been wrapped in a Spring Boot Maven web structure. The backend Tomcat web server hosts the website and serves all assets (HTML, CSS, JS, images) statically at the root context directory, preserving all relative file paths.

---

## Features
- **Modern Landing Page**: High-contrast bento grid layout representing the immersive silent disco event, channels information, and schedule.
- **Interactive Registration System**: Browser-side validation and secure database storage powered by Supabase.
- **Headset Ticket Reservation**: Collision-free unique Ticket ID generation (`SD-2025-{timestamp}-{random}`).
- **Asymmetric Channels Grid**: Informative section explaining frequency mappings for the 3 DJ channels (Blue, Pink, Green).
- **Spring Boot Standard Wrapper**: Leverages Java 23 and Spring Boot Web Starter to host the application.
- **Maven Wrapper Integration**: Supports portable build execution via `.mvnw` without necessitating global Maven installations.

---

## Technologies Used
* **Core Language:** Java 21
* **Framework:** Spring Boot 3.3.4 (Starter Web, Starter Test)
* **Build System:** Apache Maven (with Maven Wrapper `mvnw`)
* **Frontend Web Stack:** HTML5, CSS3, Tailwind CSS (via CDN), JavaScript (ES6)
* **Database & BaaS:** Supabase JS SDK (Client-side integration)
* **Aesthetics & Design:** Material Symbols Outlined, Google Fonts (Anton, Inter, JetBrains Mono)

---

## Project Structure
```text
Silent-Disco-DevOps/
├── .mvn/                             # Maven Wrapper properties and jar binaries
│   └── wrapper/
│       ├── maven-wrapper.jar
│       └── maven-wrapper.properties
├── src/
│   └── main/
│       ├── java/                     # Java Source Files
│       │   └── com/
│       │       └── silentdisco/
│       │           └── devops/
│       │               └── SilentDiscoApplication.java
│       └── resources/                # Properties and Static Web Files
│           ├── application.properties
│           └── static/
│               ├── assets/           # Event images and artwork
│               │   ├── dj_cyan.png
│               │   ├── dj_magenta.png
│               │   └── dj_neon.png
│               ├── confirmation.html
│               ├── event-info.html
│               ├── index.html
│               ├── register.html
│               └── supabase.js       # Supabase client initialization
├── .gitignore                        # Standard files to ignore in Git
├── mvnw                              # Unix Maven Wrapper script
├── mvnw.cmd                          # Windows Maven Wrapper script
└── pom.xml                           # Maven project config (Spring Boot & dependencies)
```

---

## Build Instructions

### Prerequisites
Before compiling the project, verify that **Java 21/25 JDK** is installed on your operating system:
```cmd
java -version
```
Additionally, ensure you set the `JAVA_HOME` environment variable to point to your JDK installation (e.g. `C:\Program Files\Java\jdk-21` on Windows).

### Compiling and Packaging
To clean, compile, run tests, and package the application into an executable fat-jar:

**Windows CMD:**
```cmd
set JAVA_HOME=C:\Program Files\Java\jdk-21
mvnw.cmd clean package
```

**PowerShell:**
```powershell
$env:JAVA_HOME = "C:\Program Files\Java\jdk-21"
.\mvnw.cmd clean package
```

**macOS / Linux:**
```bash
export JAVA_HOME=/path/to/jdk-21
chmod +x mvnw
./mvnw clean package
```

The output build file will be generated at `target/devops-0.0.1-SNAPSHOT.jar`.

---

## Run Instructions

To run the embedded Apache Tomcat server locally on port `8080`:

**Windows CMD:**
```cmd
set JAVA_HOME=C:\Program Files\Java\jdk-21
mvnw.cmd spring-boot:run
```

**PowerShell:**
```powershell
$env:JAVA_HOME = "C:\Program Files\Java\jdk-21"
.\mvnw.cmd spring-boot:run
```

Once running, access the local website at:
**[http://localhost:8080/](http://localhost:8080/)**

---

## Future DevOps Pipeline (Next Stages)
This project is structured for seamless integration with modern automated pipelines:
1. **Source Control (GitHub):** Standard project repository structure and `.gitignore` setup.
2. **Continuous Integration (Jenkins):** Scripted Jenkinsfile deployment using `./mvnw clean package` for automated code verification.
3. **Containerization (Docker):** Standard Multi-Stage Dockerfile containing JDK 21 runtime environments.
4. **Orchestration (Kubernetes):** Kubernetes manifest deployments (`deployment.yaml`, `service.yaml`) for auto-scaling and traffic routing.
5. **Monitoring & Logging (Nagios / Graphite / Grafana):** Incorporating Spring Boot Actuator metrics pushed to Prometheus/Graphite registries, with Grafana dashboards for visualization and Nagios health checks.

## Author
Adityesh Raghav
