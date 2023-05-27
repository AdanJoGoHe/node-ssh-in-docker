# The docker image name
$imageName = "node-and-ssh"
# The port for SSH
$port = 2222

Write-Host "Choose an option:"
Write-Host "1. Build and run Docker image"
Write-Host "2. Remove all Docker containers with image name"
$input = Read-Host "Please enter your choice (1 or 2)"

if ($input -eq "1") {
    # Build and run Docker image
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
} elseif ($input -eq "2") {
    # Remove all Docker containers with image name
    Write-Host "Removing all containers with the same image name..." -ForegroundColor Yellow
    $existingContainers = docker ps -aq --filter ancestor=$imageName
    if ($existingContainers) {
        docker stop $existingContainers
        docker rm $existingContainers
        if ($?) {
            Write-Host "Successfully removed all containers" -ForegroundColor Green
        } else {
            Write-Host "Something went wrong" -ForegroundColor Red
        }
    } else {
        Write-Host "No containers with the image name found."
    }
} else {
    Write-Host "Invalid input. Please enter either 1 or 2."
}
