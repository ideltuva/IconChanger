Write-Host "Loading the function..."
function ConvertToIcon
{

    <# 
    .Synopsis 
        Converts image to icons 
    .Description 
        Converts an image to an icon 
    .Example
		Import-Module ConvertToIcon.psm1
        ConvertToIcon -File .\emoji.png -OutputFile .\emoji.ico 
    #>
    [CmdletBinding()]
    param(
    # The file 
    [Parameter(Mandatory=$true, Position=0,ValueFromPipelineByPropertyName=$true)]
    [Alias('Fullname')]
    [string]$File,
    
    # If set, will output bytes instead of creating a file
    [switch]$InMemory,
    
    # If provided, will output the icon to a location
    [Parameter(Position=1, ValueFromPipelineByPropertyName=$true)]
    [string]$OutputFile
    )
    
    begin {
		Write-Host "ConvertToIcon is running!"
        Add-Type -AssemblyName System.Windows.Forms, System.Drawing
		Write-Host "Done"
        
    }
    
    process {
        #region Load Icon
        $resolvedFile = $ExecutionContext.SessionState.Path.GetResolvedPSPathFromPSPath($file)
        if (-not $resolvedFile) { return }
        $loadedImage = [Drawing.Image]::FromFile($resolvedFile)
        $intPtr = New-Object IntPtr
        $thumbnail = $loadedImage.GetThumbnailImage(72, 72, $null, $intPtr)
        $bitmap = New-Object Drawing.Bitmap $thumbnail 
        $bitmap.SetResolution(72, 72); 
        $icon = [System.Drawing.Icon]::FromHandle($bitmap.GetHicon());         
        #endregion Load Icon

        #region Save Icon
        if ($InMemory) {                        
            $memStream = New-Object IO.MemoryStream
            $icon.Save($memStream) 
            $memStream.Seek(0,0)
            $bytes = New-Object Byte[] $memStream.Length
            $memStream.Read($bytes, 0, $memStream.Length)                        
            $bytes
        } elseif ($OutputFile) {
            $resolvedOutputFile = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($outputFile)
            $fileStream = [IO.File]::Create("$resolvedOutputFile")                               
            $icon.Save($fileStream) 
            $fileStream.Close()               
        }
        #endregion Save Icon

        #region Cleanup 
        $icon.Dispose()
        $bitmap.Dispose()
        #endregion Cleanup 

    }
}
Write-Host "Done"
