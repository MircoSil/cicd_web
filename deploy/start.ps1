param(
  [string]$Image = "ghcr.io/mircosil/cicd_web:latest",
  [string]$Name = "my-webapp",
  [int]$Port = 80
)

docker pull $Image
if (docker ps -a --format "{{.Names}}" | Select-String -SimpleMatch $Name) {
  docker rm -f $Name | Out-Null
}
docker run -d --name $Name -p ${Port}:80 --restart unless-stopped $Image
$InformationPreference = 'Continue'
Write-Information "Running $Name on http://localhost:$Port"
