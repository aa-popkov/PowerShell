$curDate = Get-Date -Format "yyyy-MM-dd__HH-mm";
$destPath = "D:\backup";
$userPath = $env:USERPROFILE;
$sourcePath = "$userPath\Downloads";

$countObjInSourcePath = (Get-ChildItem -Recurse -Path $sourcePath | Measure-Object).Count;

if ($countObjInSourcePath -eq 0) {
    Write-Output "No files/Directory for backup ):"
    exit;
}

& "C:\Program Files\7-Zip\7z.exe" a -tzip -ssw -mx1 -sdel -r0 $destPath\backup_$curdate.zip $sourcePath\*;
Write-Output "Proccess archivated completed!"