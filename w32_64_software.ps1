$pfad1 = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion | Where-Object { ($_.DisplayName -notlike "*Update*") -and ($_.DisplayName -ne $NULL) } | sort DisplayName
$pfad2 = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion | Where-Object { ($_.DisplayName -notlike "*Update*") -and ($_.DisplayName -ne $NULL) } | sort DisplayName
$pfad = $pfad1 + $pfad2
$replace = @{'Microsoft'='MS'
        'Visual'='Vis'
        'McAfee Endpoint Security'='McAfee ENS' 
        'Redistributable'='Red'
        'Additional'='Ad'
        'Minimum'='Min'
        'Windows'='Win'
        'AnyConnect Secure Mobility Client'='ACSM Client' 
        'Language Pack'='lang'}
        
$pfad_s = $pfad | sort -Unique DisplayName
$obj = foreach($val in $pfad_s){
    $name = $val.DisplayName
    $version = $val.DisplayVersion
        foreach($key in $replace.Keys){
            $name = $name.replace($key, $replace[$key])
        }
            [PSCustomObject]@{
            Name = $name -replace '\-?\s?[v]?\s?(\d{1,}\.)+(\d{1,})?([-+]\d{1,})?', ''
            Version = $version
            }    
    }   
$obj | Format-Table
