@echo off
setlocal enabledelayedexpansion

:: Verifica se pelo menos um argumento foi passado
if "%1"=="" (
    goto usage
)

:: Comando 'start' para iniciar o Docker Compose
if "%1"=="start" (
    echo Iniciando Docker Compose...
    docker-compose up -d
    exit /b
)

:: Comando 'build' para criar uma imagem Docker
if "%1"=="build" (
    if "%2"=="" (
        echo Erro: Nome da imagem nao informado!
        echo Uso: docker-util build <imagem>
        exit /b 1
    )
    echo Construindo imagem Docker: %2
    docker build -t %2 .
    exit /b
)

:: Comando 'stop' para parar um container específico
if "%1"=="stop" (
    if "%2"=="" (
        echo Nenhum container informado. Listando containers em execucao:
        for /f "delims=" %%i in ('docker ps --format "{{.Names}}"') do (
            echo %%i
        )
        set /p container=Digite o nome do container: 
        if "%container%"=="" (
            echo Nenhum container selecionado.
            exit /b 1
        )
    ) else (
        set container=%2
    )
    echo Parando container: %container%
    docker stop %container%
    exit /b
)

:: Comando 'stop-all' para parar todos os containers
if "%1"=="stop-all" (
    echo Parando todos os containers em execucao...
    for /f "delims=" %%i in ('docker ps -q') do docker stop %%i
    exit /b
)

:: Comando 'bash' para entrar no container
if "%1"=="bash" (
    if "%2"=="" (
        echo Nenhum container informado. Listando containers em execucao:
        for /f "delims=" %%i in ('docker ps --format "{{.Names}}"') do (
            echo %%i
        )
        set /p container=Digite o nome do container: 
        if "%container%"=="" (
            echo Nenhum container selecionado.
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

    echo Acessando container '%container%' como usuario '%user%'...
    docker exec -it %container% cmd
    exit /b
)

:: Caso nenhum comando válido seja passado
:usage
echo Uso: docker-util <comando>
echo.
echo Comandos disponiveis:
echo   start             - Inicia o Docker Compose
echo   build <img>       - Constrói uma imagem Docker
echo   stop <cont>       - Para um container especifico (ou permite escolher)
echo   stop-all          - Para todos os containers em execucao
echo   bash <cont> [usr] - Abre terminal dentro de um container (padrão: root)
exit /b 1
