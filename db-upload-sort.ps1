# Set the path to the Dropbox folder
$dropboxFolderPath = "C:\Path\To\Dropbox\Folder"

# Get unsorted files.
$unsortedFiles = Get-ChildItem -Path $dropboxFolderPath | Where-Object { $_.PSIsContainer -eq $false }

# Iterate through each unsorted file
foreach ($file in $unsortedFiles) {
    # Extract the submitter's first and last names
    $nameParts = $file.Name -split " "
    $firstName = $nameParts[0]
    $lastName = $nameParts[1]

    # Set the folder path
    $folderPath = Join-Path -Path $dropboxFolderPath -ChildPath "$firstName $lastName"

    # Create the folder *if* it doesn't exist
    if (-not (Test-Path -Path $folderPath -PathType Container)) {
        New-Item -Path $folderPath -ItemType Directory | Out-Null
    }

    # Move the file to the appropriate folder
    $destinationPath = Join-Path -Path $folderPath -ChildPath $file.Name
    Move-Item -Path $file.FullName -Destination $destinationPath -Force
}
