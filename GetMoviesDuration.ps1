$Shell = New-Object -ComObject Shell.Application;
$fileFromat = @("mp4", "mkv");                  # Add another
$filesPath = "$env:USERPROFILE\Downloads\"      # Your files directory

Get-ChildItem -Path $filesPath -Recurse -Force | ForEach-Object { 
    if($_.Name.Split(".")[-1] -in $fileFromat) {
        $Folder = $Shell.Namespace($_.DirectoryName)
        $File = $Folder.ParseName($_.Name)
        $Duration = $Folder.GetDetailsOf($File, 27)
        [PSCustomObject]@{
            Name = $_.Name
            Format = $_.Name.Split(".")[-1]
            Size = "$([int]($_.length / 1mb)) MB"
            Duration = $Duration
        }
    }
} | Export-Csv -Path "./temp.csv" -NoTypeInformation -Encoding UTF8 -Delimiter ";"