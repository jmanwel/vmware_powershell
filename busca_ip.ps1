$server = @(
@{url='url_vcenter_to_connect'}
)

$user='your_user'
$pass ='your_password'

foreach($s in $server){
Try{
    Connect-VIServer -Server $s['url'] -Protocol https -User $s['user']  -Password $pass
    $path = "your_path"
    $ip = Get-VM  | Select Name, @{N="IP";E={@($_.guest.IPaddress)}},Notes,@{N="VMHost";E={@($_.VMHost.Name)}},UsedSpaceGB,ProvisionedSpace, @{N="Cluster";E={Get-Cluster -VM $_}}
    $json = $ip | ConvertTo-JSON -Depth 10
        $json > $path
    Disconnect-VIServer -Server $s['url'] -confirm:$false
}Catch{
    $hora = get-date -displayhint time
    $path = "your_path"
    echo "Error de conexión - $hora" >> $path
}
}
