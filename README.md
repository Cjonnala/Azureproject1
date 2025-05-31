# 🛠️ Azure VM + NGINX + Ansible + Terraform Project – by Chaitanya

Hi, I’m **Chaitanya** 👋

This project demonstrates how to deploy a customized static web page (a puppy-themed student registration form 🐶) on an Azure Virtual Machine using **Terraform for provisioning** and **Ansible for configuration management**. It reflects the kind of work I enjoy—clean infrastructure automation with a creative twist.

---

##  What This Project Does

 Provisions infrastructure on Microsoft Azure  
 Creates a secure Linux Virtual Machine  
 Automatically opens ports 22 (SSH) and 80 (HTTP)  
 Installs and configures NGINX  
 Deploys a custom HTML page styled with CSS and a puppy image  
 Supports start/stop VM controls to save Azure costs  

## Technologies & Azure Services Used

- Azure Virtual Machine (`azurerm_linux_virtual_machine`)
- Public IP (`azurerm_public_ip`)
- Network Interface (`azurerm_network_interface`)
- Virtual Network & Subnet (`azurerm_virtual_network`, `azurerm_subnet`)
- Network Security Group + Association (`azurerm_network_security_group`, `azurerm_subnet_network_security_group_association`)   
- Resource Group (`azurerm_resource_group`)
- Terraform – Infrastructure as Code
- Ansible – Configuration Management
- NGINX – Web server
- HTML/CSS – Frontend

## How to Run

### Step 1: Provision Infrastructure with Terraform

cd terraform

terraform init

terraform plan

terraform apply

### Step 2: Configure the VM and Deploy the App with Ansible
cd ../ansible

ansible-playbook -i inventory.ini nginx.yml

### Step 3: Access the Web Page
Open your browser and visit: http://<your-public-ip>

### You’ll see a student registration form on a puppy-themed background. After submitting, a thank-you page with a cute image will be shown.

<img width="940" alt="image" src="https://github.com/user-attachments/assets/c4ef1f4e-839a-4ad4-b8b4-c8c26484b621" />

<img width="902" alt="image" src="https://github.com/user-attachments/assets/ca2a68aa-fa89-4e3a-9f53-8d6edc19ad93" />



### Connect with Me
GitHub: https://github.com/Cjonnala
LinkedIn: https://www.linkedin.com/in/chaitanya-jonnala/
