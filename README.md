# 🚀 Automated Log4Shell (CVE-2021-44228) Play & Plug Lab

An automated, single-command security research laboratory designed to demonstrate and audit the **Log4Shell (CVE-2021-44228)** Remote Code Execution (RCE) vulnerability. 

This project consolidates all necessary components (vulnerable application, malicious LDAP referral server, and attacker tools) into a unified, isolated network infrastructure using Docker Compose.

---

## ⚙️ Key Features

* **100% Plug & Play:** No manual IP configuration, `.env` file editing, or network alignment required. Everything resolves automatically via Docker's internal DNS.
* **Bytecode Compatibility:** Exploit code is automatically cross-compiled forcing compatibility with the victim's older Java Virtual Machine (JVM) architecture, eliminating `UnsupportedClassVersionError` issues.
* **Centralized Deployment:** Controlled entirely by a single orchestration layer and an interactive Bash script manager (`configurar.sh`) that automates container teardown, cache clearing, and rebuilds.

---

## 🏗️ Architecture Overview

The laboratory creates an isolated bridge network (`red-log4shell`) with three key actors:

1.  **Victim (`web-vulnerable`):** A Spring Boot web application utilizing an unmitigated, vulnerable version of Log4j (`2.14.1`) running on **Java 8u111**.
2.  **LDAP Server (`ldap-malicioso`):** Powered by `marshalsec` to intercept incoming lookup requests and dynamically redirect the victim to the attacker's payload.
3.  **Attacker (`kali-tools`):** A custom Kali Linux container hosting a Python HTTP server to deliver the compiled exploit payload (`Exploit.class`) and a Netcat listener to catch the reverse shell.

---

## ⚙️ Quick Start

To deploy this laboratory on any Linux machine with Docker installed, execute the following commands in your terminal:

```bash
# 1. Clone the repository
git clone https://github.com/MAFO-sec/mi-laboratorio-log4shell.git

# 2. Navigate to the project directory
cd mi-laboratorio-log4shell

# 3. Grant execution permissions to the script manager and launch the lab
chmod +x configurar.sh
./configurar.sh
```

---

## ⚠️ Disclaimer

This repository is created strictly for **educational purposes, security research, and authorized academic auditing**. Never execute these tools or attack infrastructure without explicit, prior written authorization from the infrastructure owners.
