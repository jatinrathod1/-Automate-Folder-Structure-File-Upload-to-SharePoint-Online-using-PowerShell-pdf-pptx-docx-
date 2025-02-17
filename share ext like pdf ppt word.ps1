# Define SharePoint site and document library details
$siteUrl = "https://futurrizoninterns.sharepoint.com/sites/MentalHealthCareWebApplication1"
$libraryName = "CustomDocumentLibrary"
$libraryDisplayName = "Custom Document Library"
$localPath = "E:\Work FT\Hierarchical_Files_Library_5355_TEST"  

# Connect to SharePoint Online (Interactive login)
Connect-PnPOnline -URL $siteUrl -UseWebLogin

# Check if the document library exists
$library = Get-PnPList -Identity $libraryName -ErrorAction SilentlyContinue
if (-not $library) {
    Write-Host "Creating document library: $libraryDisplayName..."
    New-PnPList -Title $libraryDisplayName -Url $libraryName -Template DocumentLibrary -OnQuickLaunch
} else {
    Write-Host "Document library '$libraryDisplayName' already exists."
}

# Function to create folder structure and upload files to SharePoint Document Library
function Create-SharePointFoldersAndUploadFiles {
    param (
        [string]$folderPath
    )

    # Get all subfolders recursively
    $folders = Get-ChildItem -Path $folderPath -Directory -Recurse

    foreach ($folder in $folders) {
        # Get relative path
        $relativePath = $folder.FullName.Replace($localPath, "").TrimStart("\")
        $relativePath = $relativePath -replace "\\", "/"

        Write-Host "Creating folder in SharePoint: $relativePath"

        # Split the relative path into folder levels
        $folderLevels = $relativePath -split "/"
        $currentPath = ""

        foreach ($level in $folderLevels) {
            $parentFolder = $currentPath
            $currentPath = if ($currentPath -eq "") { $level } else { "$currentPath/$level" }

            # Check if folder exists before creating
            $existingFolder = Get-PnPFolder -Url "$libraryName/$currentPath" -ErrorAction SilentlyContinue
            if (-not $existingFolder) {
                Write-Host "Creating folder: $currentPath"

                if ($parentFolder -eq "") {
                    # Create top-level folder inside the document library
                    Add-PnPFolder -Name $level -Folder $libraryName
                } else {
                    # Create subfolder inside the correct parent folder
                    Add-PnPFolder -Name $level -Folder "$libraryName/$parentFolder"
                }
            }
        }

        # Upload PDF, PPT, and Word files in the current folder to SharePoint
        $fileTypes = "*.pdf", "*.pptx", "*.docx"
        foreach ($fileType in $fileTypes) {
            $files = Get-ChildItem -Path $folder.FullName -Filter $fileType
            foreach ($file in $files) {
                $sharePointPath = "$libraryName/$relativePath/$($file.Name)"
                Write-Host "Uploading file: $($file.Name) to $sharePointPath"

                # Upload the file to the corresponding SharePoint folder
                Add-PnPFile -Path $file.FullName -Folder "$libraryName/$relativePath"
            }
        }
    }
}

# Call the function to upload folder structure and files
Write-Host "Creating folder structure and uploading PDF, PPT, and Word files to SharePoint..."
Create-SharePointFoldersAndUploadFiles -folderPath $localPath

Write-Host "Process completed successfully!"
