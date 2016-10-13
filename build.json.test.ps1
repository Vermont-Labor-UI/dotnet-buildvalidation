if(!(Test-Path 'build.json')) {
    Write-Output "No build.json is found.  It is needed for this build to work".
    exit 1;
}

$build = (Get-Content .\build.json | Out-String | ConvertFrom-Json)
if(!($build))
{
  Write-Output "Cannot parse build.json"
  exit 1;
}
if($build.builds)
{
  Write-Output "Validating Builds:  $_"
  $build.builds | ForEach {
    if(!($_.path))
    {
      Write-Output "$_ is missing the path attribute"
      exit 1;
    }
  }
}

if($build.deploys)
{
  $build.deploys | ForEach {
    Write-Output "Validating Deploys:  $_"
    if(!($_.path))
    {
      Write-Output "$_ is missing the path attribute"
      exit 1;
    }
    if(!($_.name))
    {
      Write-Output "$_ is missing the name attribute"
      exit 1;
    }
  }
}

if($build.packages)
{
  Write-Output "Validating Packages:  $_"
  $build.packages | ForEach {
    if(!($_.path))
    {
      Write-Output "$_ is missing the path attribute"
      exit 1
    }
  }
}
