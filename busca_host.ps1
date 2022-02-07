$server = @(
@{url='url_vcenter_to_connect'}
)

$user='your_user'
$pass ='your_password'

foreach($s in $server){
$url = $s['url']
Try{
    Connect-VIServer -Server $url -Protocol https -User $s['user']  -Password $pass
    $path = "your_path"
    (Get-VM $s['name'] | select VMHost) -Split "\n" > $path
    Disconnect-VIServer -Server $s['url'] -confirm:$false
}Catch{
    $hora = get-date -displayhint time
    $path = "/home/jmg/" + $url +"_error"
    echo "Error de conexión a $url $hora" >> $path
}
}