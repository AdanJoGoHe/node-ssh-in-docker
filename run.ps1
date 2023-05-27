# The docker image name
$imageName = "node-and-ssh"
# The port for SSH
$port = 2222

Write-Host "Removing previous containers with the same image name..." -ForegroundColor Yellow
# Stop and remove previous containers based on the image
$existingContainers = docker ps -aq --filter ancestor=$imageName
if ($existingContainers) {
    docker stop $existingContainers
    docker rm $existingContainers
}

$connectionStatus
$connection = Test-NetConnection -ComputerName localhost -Port $port -ErrorAction SilentlyContinue
if ($connection -and $connection.TcpTestSucceeded) {
    $processId = $connection.OwningProcess
    $process = Get-Process -Id $processId
    $connectionStatus = $false
    if ($process) {
        $processName = $process.ProcessName
        Write-Host "Port $port is occupied by the process $processName (ID: $processId)."
    } else {
        Write-Host "Port $port is occupied by an unknown process."
    }
} else {
    Write-Host "Port $port is available."
    $connectionStatus = $true
}

if ($connectionStatus) {
    # Build the Docker image
    Write-Host "Building the container..." -ForegroundColor Green
    docker build -t $imageName .
    if ($?) {
        Write-Host "Successfully built" -ForegroundColor Green
    } else {
        Write-Host "Something went wrong" -ForegroundColor Red
    }

    # Run a new container based on the image
    docker run -p 2222:22 -d $imageName
    if ($?) {
        Write-Host "Successfully ran the container" -ForegroundColor Green
    } else {
        Write-Host "Something went wrong" -ForegroundColor Red
    }
}
