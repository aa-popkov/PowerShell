$regPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings";
$currentProxyState = (Get-ItemPropertyValue -path $regPath ProxyEnable -ErrorAction Stop).toString();

$outputMessage = "Current proxy state is:`n";
$targetProxyState;

if($currentProxyState -eq "0"){
    $outputMessage += "DISABLE`nEnabled proxy?(yes/no)";
    $targetProxyState = 1;
}

if($currentProxyState -eq "1"){
    $outputMessage += "ENABLE`nDisabled proxy?(yes/no)";
    $targetProxyState = 0;
}


while ($true) {
    $inputMessage = Read-Host $outputMessage;

    if($inputMessage -match '[yY]es|[yY]'){
        Set-ItemProperty -path $regPath ProxyEnable -value $targetProxyState -ErrorAction Stop;
        exit;
    } elseif ($inputMessage -match '[nN]o|[nN]') {
        exit;
    } else {
        Write-Output "Only Yes/No! jerk ... :\`n"
    }
}
