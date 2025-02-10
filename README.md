# Lighthouse Challenge Indicium

## Project Description
This project was developed as the final stage of the Lighthouse program, aiming to evaluate participants technically and track their progress throughout the program.

## Introduction
The project involves creating infrastructure in Databricks using Terraform to extract data from an MSSQL database into a raw catalog in Databricks, followed by transformations and loading into an stg catalog. Each stage is documented below with direct links for easier navigation:

- [Setting Up the Environment](#setting-up-the-environment)
- [Infrastructure](#infrastructure)
- [Development](#development)
  - [Extraction](#extraction-mssql_to_raw)
  - [Transformation](#transformation-raw_to_stg)
- [Job Execution](#job-execution)
- [Final Considerations](#final-considerations)

## Setting Up the Environment
Installations followed the official documentation for each tool:

1. Terraform: [Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/azure-get-started/install-cli)
2. Azure CLI: [Install Azure CLI on Linux](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)
3. Databricks CLI: [Install Databricks CLI](https://docs.databricks.com/en/dev-tools/cli/install.html)

Additionally, we used the Databricks extension in VSCode to facilitate connection and interaction with the platform. All activities were performed in a Windows + WSL environment.

## Infrastructure
The infrastructure was created using Terraform. It includes:

- Raw and STG catalogs with their respective schemas.
- Configuration of sensitive variables in the `.env` file.
- Connection to Databricks on Azure using a token generated on the platform.

Below is the architecture diagram for this project:

![Architecture Diagram](desafio_lh_arquitetura.drawio.png)

### Deployment Commands for Infrastructure
1. Initialization: `terraform init`
2. Planning: `terraform plan`
3. Application: `terraform apply`

With the infrastructure ready, we moved on to developing the notebooks.

## Development
Development involved two main notebooks created in the `src` folder:

1. **Extraction** ([mssql_to_raw](#extraction-mssql_to_raw)): Connects to the MSSQL database and extracts tables into the raw catalog.
2. **Transformation** ([raw_to_stg](#transformation-raw_to_stg)): Applies transformations to the data and loads it into the stg catalog.

### Extraction [mssql_to_raw]
Each notebook cell performs a specific task:

1. **Spark Session Configuration:**
   - Initializes the Spark session for executing data operations.

2. **Loading Secrets and Connection Parameters:**
   - Fetches database credentials from Databricks Secrets.
   - Configures the JDBC connection URL to the MSSQL database.

3. **Fetching Table Names Dynamically:**
   - Retrieves the list of tables dynamically using SQL queries.

4. **Extracting and Writing Tables to RAW Catalog:**
   - Iterates over tables and loads data from MSSQL into the RAW catalog in Databricks.
   - Uses Delta format for optimized storage and querying.

5. **Validation and Logging:**
   - Ensures extracted data is stored correctly.
   - Logs completion messages for each table.

### Transformation [raw_to_stg]
Each notebook cell performs a specific task:

1. **Loading Metadata from YAML:**
   - Reads the `transformations.yml` file to determine column transformations.

2. **Applying Data Transformations:**
   - Casts column types according to YAML specifications.
   - Renames columns to `snake_case` format.
   - Expands XML columns into separate structured fields when applicable.

3. **Handling XML Fields for Store Table:**
   - Extracts nested XML fields and converts them into separate columns.
   - Uses XPath expressions to parse values within the XML structure.

4. **Writing Data to STG Catalog:**
   - Writes the transformed data into the STG catalog in Delta format.

5. **Validation and Final Check:**
   - Ensures that transformed tables are successfully saved and accessible.

## Job Execution
Jobs were configured and executed using Databricks Bundles. During development, we used the command:

```bash
databricks bundle deploy -t dev
```

After validations, the production environment was configured with:

```bash
databricks bundle deploy -t prod
```

## Final Considerations
This project successfully met the challenge requirements, demonstrating technical skills in setting up infrastructure, developing data pipelines, and automating processes in Databricks. The structured approach ensured efficiency in data extraction, transformation, and validation. The use of Terraform, Databricks, and automation techniques allowed the creation of a scalable and well-documented data pipeline that can be extended for future enhancements.
