$here = Split-Path -Parent $MyInvocation.MyCommand.Path
#$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
#. "$here\$sut"
Import-Module Pester
Import-Module ActiveDirectory
Import-Module \\md1-cifs01\users\rderickson\scripts\GitLocal\Example\Example.psm1

Describe "Example" {
    Mock Import-Csv {
        return @{
            Site = 'TST'
            DataPath = '\\files\data.csv'
        }
    } -ParameterFilter { $Path -and $Path.StartsWith('\\files\sites.csv') }
    
    Mock Import-Csv {
        return @{
            TheData = 'Some Data'
            Location = 'MyLoc'
        }
    } -ParameterFilter { $Path -and $Path.StartsWith('\\files\data.csv') }
    
    Context "When the Example executes" {
        $result = Example -Site 'TST' -Path '\\files\sites.csv' -Location = 'MyLoc'
        It "Returns the data" {
            $result.Data | Should Be 'Some Data'
        }
    }
}