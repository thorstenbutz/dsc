$path = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
$propertyName = 'TaskbarAl'
$alignLeft = 0
$alignCenter = 1
$propertyType = 'DWORd'

Get-ItemProperty -Path $path -Name $propertyName
New-ItemProperty -Path $path -Name $propertyName -Value $alignLeft -PropertyType $propertyType 
Set-ItemProperty -Path $path -Name $propertyName -Value $alignCenter
Remove-ItemProperty -Path $path -Name $propertyName