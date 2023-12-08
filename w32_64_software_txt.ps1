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
        'Software Development Kit' = 'SDK'
        'AnyConnect Secure Mobility Client'='ACSM Client' 
        'Language Pack'='lang'}
$out = New-Item '.\out_sw.txt' -force
$pfad_s = $pfad | sort -Unique DisplayName
foreach($val in $pfad_s){
    $name = $val.DisplayName
    $version = $val.DisplayVersion
        foreach($key in $replace.Keys){
            $name = $name.replace($key, $replace[$key])
        }
        $name = $name -replace '\-{0,1}\s{0,1}[v]{0,1}\s{0,1}\.{0,1}\d+\.(\d+\.\d+)?(\d+\.\d+)?(\.{0,1}\d+)?' , ''
        Add-Content $out -Value ('0 "WinSoftware" - {0} version {1}' -f $name, $version)
}
