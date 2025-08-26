@echo off
setlocal enabledelayedexpansion

:: Check if at least one argument was passed
if "%1"=="" (
    goto usage
)

:: 'start' command to start Docker Compose
if "%1"=="start" (
    echo Starting Docker Compose...
    docker-compose up -d
    exit /b
)

:: 'build' command to create a Docker image
if "%1"=="build" (
    if "%2"=="" (
        echo Error: Image name not provided!
        echo Usage: docker-util build <image>
        exit /b 1
    )
    echo Building Docker image: %2
    docker build -t %2 .
    exit /b
)

:: 'stop' command to stop a specific container
if "%1"=="stop" (
    if "%2"=="" (
        echo No container specified. Listing running containers:
        for /f "delims=" %%i in ('docker ps --format "{{.Names}}"') do (
            echo %%i
        )
        set /p container=Enter the container name: 
        if "%container%"=="" (
            echo No container selected.
            exit /b 1
        )
    ) else (
        set container=%2
    )
    echo Stopping container: %container%
    docker stop %container%
    exit /b
)

:: 'stop-all' command to stop all containers
if "%1"=="stop-all" (
    echo Stopping all running containers...
    for /f "delims=" %%i in ('docker ps -q') do docker stop %%i
    exit /b
)

:: 'bash' command to enter a container
if "%1"=="bash" (
    if "%2"=="" (
        echo No container specified. Listing running containers:
        for /f "delims=" %%i in ('docker ps --format "{{.Names}}"') do (
            echo %%i
        )
        set /p container=Enter the container name: 
        if "%container%"=="" (
            echo No container selected.
            exit /b 1
        )
    ) else (
        set container=%2
    )

    if "%3"=="" (
        set user=root
    ) else (
        set user=%3
    )

    echo Accessing container '%container%' as user '%user%'...
    docker exec -it --user %user% %container% bash
    exit /b
)

:: If no valid command is provided
:usage
echo Usage: docker-util <command>
echo.
echo Available commands:
echo   start             - Starts Docker Compose
echo   build <img>       - Builds a Docker image
echo   stop <cont>       - Stops a specific container (or allows selection)
echo   stop-all          - Stops all running containers
echo   bash <cont> [usr] - Opens a terminal inside a container (default: root)
exit /b 1
