$url = "https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/microsoft/153/pile-of-poo_1f4a9.png"
$output = "emoji.png"

Invoke-WebRequest -Uri $url -OutFile $output
Write-Host "Done"