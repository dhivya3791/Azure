# 📡 Azure Data Factory Logging Pipeline with Email Notifications

This project demonstrates an **Azure Data Factory (ADF)** orchestration pipeline that performs structured logging of pipeline executions and sends **email notifications** on start, success, or failure via an integrated **Azure Logic App**.

---

## 🔧 What This Pipeline Does

✅ Logs the **start of the pipeline** using a stored procedure  
✅ Executes a downstream pipeline and **captures run ID**  
✅ On success:
- Logs the **successful completion**
- Sends a **success notification email**

❌ On failure:
- Logs the **failure status**
- Sends a **failure notification email**

---

## 📘 Activities Overview

| Step | Activity Name | Type | Purpose |
|------|-------------------------------|------------|---------|
| 1 | `email notification pipeline level starting log` | Web Activity | Sends initial email (start of pipeline) |
| 2 | `Capture starting log` | Lookup | Inserts a log entry for pipeline start via stored procedure |
| 3 | `Wait1` | Wait | Simple delay (10 seconds) |
| 4 | `Execute Pipeline1` | ExecutePipeline | Runs another pipeline with `parent_id` passed as a parameter |
| 5 | `Capture ending log for success` | Stored Procedure | Logs successful run using `usp_UpdateLogsStarting` |
| 6 | `email notification ending success` | Web Activity | Sends success email |
| 7 | `Capture ending log for failure` | Stored Procedure | Logs failure if pipeline fails |
| 8 | `email notification ending fail` | Web Activity | Sends failure email |

---

## 🔄 Stored Procedures Used

- `[apr25e].[uspLogsStarting]`: Inserts starting log with metadata (pipeline name, run ID, etc.)
- `[apr25e].[usp_UpdateLogsStarting]`: Updates the pipeline run record with final status (`success` or `fail`)

---

## 🛠️ Configuration Details

### 🔹 Dataset & Linked Services
- `SqlServerTable1`: SQL dataset for logging
- `Is_efnsqlserverdev_`: Linked service pointing to SQL Server

### 🔹 Parameters Passed
- `@pipeline().DataFactory`
- `@pipeline().Pipeline`
- `@pipeline().RunId`
- `@utcNow()`
- `@activity('Capture starting log').output.value[0].id`

---

## 📧 Email Notification Logic App

This pipeline integrates with a **Logic App HTTP endpoint** to send emails.  
Notifications are triggered via Web Activity and support:

- Subject: `Data Migration`
- To: `mahiljohith@gmail.com`
- Body: Varies by step (start, success, failure)

---

## 📂 Folder Structure (recommended)

ADF-Logging-Pipeline/
├── pipeline_definition.json # This JSON
├── README.md # This file
├── stored_procedures/
│ ├── uspLogsStarting.sql
│ └── usp_UpdateLogsStarting.sql
└── screenshots/ # Optional - add pipeline diagram screenshots


---

## 🧠 Use Case

This ADF pattern is ideal for:
- Auditing pipeline executions in **enterprise ETL workflows**
- Integrating monitoring via **Logic Apps/Email**
- Generating parent-child relationships in **nested pipelines**

---

## 📌 Prerequisites

- Azure Data Factory
- Azure SQL DB (with the required stored procedures)
- Logic App with HTTP Trigger for email
- Linked services and datasets properly configured

---

## 🔐 Security Tip

- Do **not commit Logic App URLs with access tokens** to public repositories. Use environment parameters or Azure Key Vault.

---

## 📜 License

MIT License
