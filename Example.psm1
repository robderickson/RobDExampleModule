function Example {
    param(
        $Site,
        $Path,
        $Location
    )
    
    PROCESS {
        $SiteDetails = Import-Csv -Path $Path | Where-Object {$_.Site -eq $Site}
        $Data = Import-Csv -Path $SiteDetails.DataPath | Where-Object {$_.Location -eq $Location}
        $props = @{
            Data = $Data.TheData
        }
        $obj = New-Object -TypeName PSObject -Property $props
        Write-Output $obj
    }
}