param(
  [string]$ImageTag = "latest",
  [string]$Repo = "ghcr.io/mircosil/cicd_web",
  [string]$Name = "my-webapp"
)

$Image = "${Repo}:${ImageTag}"
docker pull $Image
docker stop $Name 2>$null
docker rm $Name 2>$null
docker run -d --name $Name -p 80:80 --restart unless-stopped $Image
Write-Host "Updated $Name to $Image"
