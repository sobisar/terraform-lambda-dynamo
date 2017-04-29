# from http://stackoverflow.com/questions/1153126/how-to-create-a-zip-archive-with-powershell#answer-13302548

$applicationName = "FirstLambda"

function ZipFiles( $zipfilename, $sourcedir )
{
   Add-Type -Assembly System.IO.Compression.FileSystem
   $compressionLevel = [System.IO.Compression.CompressionLevel]::Optimal
   [System.IO.Compression.ZipFile]::CreateFromDirectory($sourcedir,
        $zipfilename, $compressionLevel, $false)
}

dotnet restore
dotnet publish -c release
if ($LASTEXITCODE -ne 0) { return }

$publishDirectory = "$applicationName/bin/Release/netcoreapp1.0/publish"
$now = (Get-Date).ToString("yyyy-MM-dd-hh-mm-ss")
$packageName = "$applicationName-package-$now.zip"

rm "$publishDirectory/$packageName" -ErrorAction SilentlyContinue
ZipFiles "$(pwd)/$packageName" "$(pwd)/$publishDirectory"

$placeToPutArchivedDeployments = "PastDeploymentZips"
$nameOfCurrentDeployment = "$applicationName-CurrentDeploy.zip"

New-Item -ItemType Directory -Path $placeToPutArchivedDeployments -ErrorAction SilentlyContinue

rm $nameOfCurrentDeployment -ErrorAction SilentlyContinue
Copy-Item $packageName $nameOfCurrentDeployment
Move-Item $packageName $placeToPutArchivedDeployments
