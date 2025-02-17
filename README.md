# 📂 Automate Folder Structure & File Upload to SharePoint Online using PowerShell

## 🚀 Overview
This PowerShell script helps in **automating the creation of a hierarchical folder structure** and **uploading PDF, Word (DOCX), and PowerPoint (PPTX) files** to a SharePoint Online **document library**. If the document library doesn't exist, it will be created automatically.

## 📌 Features
✅ Connects to **SharePoint Online** using **PnP PowerShell**  
✅ Creates a **document library** if it doesn't exist  
✅ **Generates folder hierarchy** inside the SharePoint document library  
✅ **Uploads files** (PDF, DOCX, PPTX) to the correct folder structure  
✅ **Ensures folders are not duplicated** before creation  
✅ Provides **console logs** for better tracking  

## 📋 Prerequisites
Before running this script, ensure you have:

1️⃣ **PnP PowerShell** module installed:  
   ```powershell
   Install-Module -Name PnP.PowerShell -Scope CurrentUser
   ```

2️⃣ **Valid SharePoint Online credentials** with access to the site  

3️⃣ **Enable COM objects** if metadata update (like PageCount) is required  

## 🛠️ How to Use

1️⃣ **Update the script** with your SharePoint details:
   ```powershell
   $siteUrl = "https://yoursharepointdomain/sites/YourSiteName"
   $libraryName = "YourLibraryName"
   $libraryDisplayName = "Your Library Display Name"
   $localPath = "C:\Path\To\Your\Local\Folder"
   ```

2️⃣ **Run the script** in PowerShell:
   ```powershell
   .\YourScriptName.ps1
   ```

3️⃣ **Monitor the logs** for progress updates.

## 🔥 Example Folder Structure
If your local folder looks like this:
```
📁 LocalFolder
 ├── 📁 A1
 │   ├── 📄 file1.pdf
 │   ├── 📄 file2.docx
 │   ├── 📁 B1
 │       ├── 📄 file3.pptx
 │       ├── 📁 C1
 │           ├── 📄 file4.pdf
```

The script will create a **similar structure** inside SharePoint:
```
📂 SharePoint Library
 ├── 📁 A1
 │   ├── 📄 file1.pdf
 │   ├── 📄 file2.docx
 │   ├── 📁 B1
 │       ├── 📄 file3.pptx
 │       ├── 📁 C1
 │           ├── 📄 file4.pdf
```

## ⚠️ Important Notes
🔹 This script does **not overwrite** existing files.  
🔹 If you need metadata updates (e.g., Page Count for DOCX/PPTX), additional configurations are needed.  
🔹 Ensure that PowerShell execution policy allows running scripts (`Set-ExecutionPolicy RemoteSigned`).  

## 🏆 Benefits
🚀 Saves time by **automating** the tedious process of manually creating folders and uploading files.  
📂 Maintains an **organized** folder structure inside SharePoint.  
⚡ Works efficiently with **large datasets**.

## 📞 Need Help?
If you encounter any issues, feel free to reach out! 💡 Happy Automating! 🚀
