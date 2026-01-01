# Grafana dashboard for monitoring linux-based system metrics
This repo contains Grafana dashboard I created to display system metrics such as CPU and Memory usage, etc of an ubuntu server.

I have provisioned the ubuntu server in AWS as an EC2 instance using Terraform. 

This project uses a module-based Terraform architecture to keep the infrastructure code clean, reusable, and easy to maintain. Each major AWS component is separated into its own module, allowing us to manage resources independently while keeping the root configuration simple and organized.

<img width="260" height="363" alt="image" src="https://github.com/user-attachments/assets/ef26bccb-dcc3-47a8-8d70-5fcf250528ab" />

## Step by Step Guide
### 1. Provision the server
First, clone the project. Then edit the variables.tf file in root directory with region, CIDR block for VPC, subnets, AMI and other variables as you prefer.

Note: You must add your own access key and secret key in relevant variable blocks.

After configuring the files, run below commands to deploy the server.

```
terraform init
terraform plan
terraform apply --auto-approve
```

`install_docker_grafana_prom.sh` file will,
- Update the packages
- Install Docker
- Add `ubuntu` user to `docker` group and refresh group membership without re-login
- Deploy `grafana`, `prometheus` and `node-exporter` containers

#### Explanation for Docker commands used in the script file
**Grafana:**

```
docker run -d --name=grafana --network monitoring -p 3000:3000 grafana/grafana
```

Explanation for Docker command:

- -d: Runs the container in detached mode, allowing it to run in the background.
- --name=grafana: Names the container “grafana” for easier management.
- -p 3000:3000: Maps port 3000 on the Docker host to port 3000 on the container, making Grafana accessible at http://server-ip:3000.

**Prometheus:**
```
docker run -d --name=prometheus --network monitoring -p 9090:9090 -v /path/to/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus
```
Explanation for Docker command:

- -v /path/to/prometheus.yml:/etc/prometheus/prometheus.yml: Mounts the configuration file from the host to the container.

### 2. Access Grafana and Prometheus

#### 2.1 Access Grafana on Docker Host:

Open a browser and go to http://server-ip:3000.
Log in with the default credentials: Username: admin | Password: admin. (You’ll be prompted to change the password after logging in.)

<img width="1366" height="768" alt="Grafana_landingPage" src="https://github.com/user-attachments/assets/1ccb570d-0011-4e23-a388-af335babe86b" />

#### 2.2 Access Prometheus:

Open a browser and go to http://server-ip:9090 to access the Prometheus interface.

<img width="1366" height="768" alt="Prometheus_dashboard" src="https://github.com/user-attachments/assets/8a571a88-1dea-43d7-ad10-b076b63feaed" />

### 3. Setup the Data source

1. **Log in to Grafana**
   - Open your browser and go to: `http://server-ip:3000`
   - Enter your credentials to log in

2. **Navigate to Data Sources**
   - Click the **gear icon (⚙️)** in the left sidebar
   - Select **"Data Sources"**

3. **Add a New Data Source**
   - Click the **"Add data source"** button
   - Choose **"Prometheus"** from the list

4. **Configure Prometheus Settings in Connection section**
   - **Prometheus server URL**: Enter the Prometheus server URL (e.g., `http://prometheus:9090`)
  
      <img width="701" height="136" alt="Screenshot 2025-11-17 163623" src="https://github.com/user-attachments/assets/7caddb2c-8c76-4849-be06-258ba4e4a734" />

5. **Test and Save**
   - Click **"Test"** to verify the connection
   - If successful, click **"Save & Test"**

### 4. Import Prebuilt Dashboard

1. **Create Dashboard**
   - In the home page of Grafana, select **Create your first dashboard**

2. **Import Dashboard**
   - Click the **plus icon (+)** in the left sidebar
   - Select **“Import”**
   - Enter **Dashboard ID: `1860`** (Node Exporter Full)
   - Click **“Load”**

3. **Configure Data Source**
   - Select your Prometheus data source
   - Click **“Import”**

4. **Save the Dashboard**
<img width="1365" height="507" alt="Screenshot 2025-11-17 164050" src="https://github.com/user-attachments/assets/1cfbbee8-a303-4164-88cf-fa85e23d1a92" />
