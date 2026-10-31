### Note:

Please make sure to create the TransportationData table in the SQL Database using the Azure portal after the SQL database is created through Terraform, because this table is needed as the output target for the Stream Analytics job.

### Prerequisites:

Install Azure CLI and configure your credentials. Install Terraform on your system.

### Azure CLI Installation Link (Windows)

```https://aka.ms/installazurecliwindows```

1. Install and setup Azure CLI File in your local system.
2. Check whether Azure CLI is setup in your local system by executing this command.

    ```az --version```

### Azure CLI Installation Link (macOS)

```brew update && brew install azure-cli```


### Configure Azure CLI on Your System

#### Execute this command on Terminal to setup Azure CLI on the local system

```az login```


1. Enter your Azure email id and password
2. Following this, the Azure CLI will be setup in your local system


This sets up local system to interact with Azure services using the CLI and necessary for the execution using terraform.


### Terraform Installation Link

https://developer.hashicorp.com/terraform/downloads

###### Install Terraform on Windows 

1. https://releases.hashicorp.com/terraform/1.13.4/terraform_1.13.4_windows_amd64.zip
2. Download the ZIP file and extract it.
3. Copy the extracted terraform.exe file.
4. Open File Explorer → navigate to C:\Program Files.
5. Create a new folder named Terraform and paste the terraform.exe file inside it.
6. Add Terraform to your system PATH:
7. Click Environment Variables → under System variables, select Path → click Edit.
8. Click New, then paste the Terraform folder path (e.g., C:\Program Files\Terraform) and Click OK to save changes.

Open Command Prompt and verify installation:

```terraform -version```


###### Install Terraform on macOS

If you don’t have Homebrew installed, first install it by executing this command on the terminal:

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


## Run this commmand to install terraform on macOS
1. brew tap hashicorp/tap
2. brew install hashicorp/tap/terraform


### Setup providers.tf in the terraform folder

Execute this command to get the tenant id and SubscriptionId and tenantId

```az account show --output json```

After getting the credentials, specify those in the providers.tf
##### Terraform Commands
Step 1: Initialize Terraform

```terraform init```


This command sets up your working directory for Terraform. It downloads the required providers and prepares the environment for deployment.


Step 2: Preview Terraform Plan

```terraform plan```

This command shows all the changes Terraform will make to infrastructure. You can review the changes safely before actually applying them.

Step 3: Validate Terraform Configuration

```terraform validate```

This command checks all Terraform files for syntax errors. It ensures that configuration is correct before applying it.

Step 4: Apply Terraform Changes

```terraform apply```

This command applies your Terraform configuration to create or update resources in AWS. You will be prompted to confirm before Terraform makes any changes.


Step 5: Apply Terraform Changes Automatically

```terraform apply --auto-approve```

This command applies all Terraform changes without asking for confirmation. It is useful for automated deployments or pipelines.


Step 6: Destroy Terraform Resources

```terraform destroy```

This command removes all resources that were created and managed by Terraform. Use this command carefully to avoid accidentally deleting important resources.