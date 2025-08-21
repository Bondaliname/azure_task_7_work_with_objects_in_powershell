$vmSize = "Standard_B2pts_v2"

$dataFolder = "data"

$jsonFiles = Get-ChildItem -Path $dataFolder -Filter *.json

$regions = @()

foreach($file in $jsonFiles){
  $filePath = $file.FullName

  $vmParameters = Get-content $filePath | ConvertFrom-Json

  $found = $vmParameters | Where-Object {$_.name -eq $vmSize}

  if ($found) {
    $region = $file.BaseName
    $regions += $region
  }
}

$regions | ConvertTo-Json | Set-Content -Path "result.json"
