param(
  [string]$Image = "ghcr.io/MircoSil/cicd_web:latest",
  [string]$Name = "my-webapp",
  [int]$Port = 80
)

docker pull $Image
if (docker ps -a --format "{{.Names}}" | Select-String -SimpleMatch $Name) {
  docker rm -f $Name | Out-Null
}
docker run -d --name $Name -p ${Port}:80 --restart unless-stopped $Image
Write-Host "Running $Name on http://localhost:$Port"
