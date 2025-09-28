param(
  [string]$ImageTag = "latest",
  [string]$Repo = "ghcr.io/mircosil/cicd_web",
  [string]$Name = "my-webapp",
  [int] $Port = 80
)

$ErrorActionPreference = 'Stop'

$Image = "${Repo}:${ImageTag}"
docker pull $Image

# Stoppe/entferne Container nur, wenn er existiert
if (docker ps -a --format "{{.Names}}" | Select-String -SimpleMatch $Name) {
    docker stop $Name | Out-Null
    docker rm $Name   | Out-Null
  }

  # Neu starten mit gewünschtem Port
  docker run -d --name $Name -p ${Port}:80 --restart unless-stopped $Image
  $InformationPreference = 'Continue'   # damit wird Information ausgegeben
  Write-Information "Updated $Name to $Image on http://localhost:$Port"
  # oder schlicht:
  # Write-Output "Updated $Name to $Image on http://localhost:$Port"
