## Eine DSC v1 kompatible Konfiguration für die Windows PowerShell
Configuration SetTaskbarAlignment {    
    
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

    Node 'sea-cl1' 
    {        
        Registry TaskbarAlignment {
            Ensure    = "Present" 
            Key       = 'HKEY_Users\S-1-5-21-1276007578-2914169427-449847108-1108\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
            ValueName = "TaskbarAL"
            ValueData = 0           ## 0 = linksbündig 
            ValueType = "DWORD"     
        }
    }
}
## Ruft die Konfiguration auf und kompliert eine MOF-Datei
SetTaskbarAlignment -OutputPath 'TaskbarAlignment'

## Startet die eigentliche Anpassung
Start-DscConfiguration -Path 'TaskbarAlignment' -Wait  # -Verbose