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
        'Strumenti di correzione di '=''
        'Outils de vérification linguistique de '=''
        'lang - DEU'='de'
        'German'='DE'
        'High Definition'='HD'
        'Software Development Kit' = 'SDK'
        'AnyConnect Secure Mobility Client'='ACSM Client'
        'Language Pack'='lang'}
$pfad_s = $pfad | sort -Unique DisplayName
$sw_liste = ''
foreach($val in $pfad_s){
    $name = $val.DisplayName
    $version = $val.DisplayVersion
        foreach($key in $replace.Keys){
            $name = $name.replace($key, $replace[$key])
        }
        $name = $name -replace '\-?\s?[v]?\s?(\d{1,}\.)+\d{1,}([-+]\d{1,})?', '' 
        $name_aus = '{0}({1}),' -f $name, $version
        $sw_liste += $name_aus
        #Write-Host ('0 "WinSoftware" - {0} version {1}' -f $name, $version)
}
$sw_liste_aus = '0 "WinSoftware" - {0}' -f $sw_liste
Write-Host $sw_liste_aus
