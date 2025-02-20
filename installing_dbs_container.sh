#!/bin/bash


##### todas as funções estão funcionando como o esperado, ainda está em fase de desenvolvimento a interface de interação com o usuário para melhor compreenção e escolha para o usuário na hora de decidir quais containers serão gerados 

function install_mariadb_container(){
    echo "Configuração do container MariaDB"

    read -p "Informe o nome do container (default: mariadb-container): " CONTAINER_NAME
    CONTAINER_NAME=${CONTAINER_NAME:-mariadb-container}

    read -p "Informe o nome do banco de dados (default: example_db): " DB_NAME
    DB_NAME=${DB_NAME:-example_db}

    read -p "Informe o nome do usuário (default: example_user): " DB_USER
    DB_USER=${DB_USER:-example_user}

    read -p "Informe a senha do usuário (default: example_password): " DB_PASSWORD
    DB_PASSWORD=${DB_PASSWORD:-example_password}

    read -p "Informe a senha do root (default: root_password): " ROOT_PASSWORD
    ROOT_PASSWORD=${ROOT_PASSWORD:-root_password}

    read -p "Informe a porta no host para expor o MariaDB (default: 3307): " HOST_PORT
    HOST_PORT=${HOST_PORT:-3307}

    # Verifica se o Docker está instalado
    if ! command -v docker &> /dev/null
    then
        echo "Docker não está instalado. Por favor, instale o Docker primeiro."
        exit 1
    fi

    # Baixa a imagem do MariaDB e cria o container
    docker pull mariadb:latest

    docker run --restart always -d --name $CONTAINER_NAME \
      -e MYSQL_ROOT_PASSWORD=$ROOT_PASSWORD \
      -e MYSQL_DATABASE=$DB_NAME \
      -e MYSQL_USER=$DB_USER \
      -e MYSQL_PASSWORD=$DB_PASSWORD \
      -p $HOST_PORT:3306 \
      -d mariadb:latest

    echo "MariaDB container criado com sucesso!"
    echo "Host: localhost, Porta: $HOST_PORT, Banco de Dados: $DB_NAME, Usuário: $DB_USER"
}

function install_postgresql_container(){
    echo "Configuração do container PostgreSQL"

    read -p "Informe o nome do container (default: postgresql-container): " CONTAINER_NAME
    CONTAINER_NAME=${CONTAINER_NAME:-postgresql-container}

    read -p "Informe o nome do usuário (default: example_user): " DB_USER
    DB_USER=${DB_USER:-example_user}

    read -p "Informe a senha do usuário (default: example_password): " DB_PASSWORD
    DB_PASSWORD=${DB_PASSWORD:-example_password}

    read -p "Informe a porta no host para expor o PostgreSQL (default: 5432): " HOST_PORT
    HOST_PORT=${HOST_PORT:-5432}

    # Verifica se o Docker está instalado
    if ! command -v docker &> /dev/null
    then
        echo "Docker não está instalado. Por favor, instale o Docker primeiro."
        exit 1
    fi

    # Baixa a imagem do PostgreSQL e cria o container
    docker pull postgres:latest

    docker run --restart always -d --name $CONTAINER_NAME \
      -e POSTGRES_USER=$DB_USER \
      -e POSTGRES_PASSWORD=$DB_PASSWORD \
      -p $HOST_PORT:5432 \
      -d postgres:latest

    echo "PostgreSQL container criado com sucesso!"
    echo "Host: localhost, Porta: $HOST_PORT, Banco de Dados: $DB_NAME, Usuário: $DB_USER"
}

function install_mysql_container(){
    echo "Configuração do container MySQL"

    read -p "Informe o nome do container (default: mysql-container): " CONTAINER_NAME
    CONTAINER_NAME=${CONTAINER_NAME:-mysql-container}

    read -p "Informe o nome do banco de dados (default: example_db): " DB_NAME
    DB_NAME=${DB_NAME:-example_db}

    read -p "Informe o nome do usuário (default: example_user): " DB_USER
    DB_USER=${DB_USER:-example_user}

    read -p "Informe a senha do usuário (default: example_password): " DB_PASSWORD
    DB_PASSWORD=${DB_PASSWORD:-example_password}

    read -p "Informe a senha do root (default: root_password): " ROOT_PASSWORD
    ROOT_PASSWORD=${ROOT_PASSWORD:-root_password}

    read -p "Informe a porta no host para expor o MySQL (default: 3306): " HOST_PORT
    HOST_PORT=${HOST_PORT:-3306}

    # Verifica se o Docker está instalado
    if ! command -v docker &> /dev/null
    then
        echo "Docker não está instalado. Por favor, instale o Docker primeiro."
        exit 1
    fi

    # Baixa a imagem do MySQL e cria o container
    docker pull mysql:latest

    docker run --restart always -d --name $CONTAINER_NAME \
      -e MYSQL_ROOT_PASSWORD=$ROOT_PASSWORD \
      -e MYSQL_DATABASE=$DB_NAME \
      -e MYSQL_USER=$DB_USER \
      -e MYSQL_PASSWORD=$DB_PASSWORD \
      -p $HOST_PORT:3306 \
      -d mysql:latest

    echo "MySQL container criado com sucesso!"
    echo "Host: localhost, Porta: $HOST_PORT, Banco de Dados: $DB_NAME, Usuário: $DB_USER"
}


# install_postgresql_container

## Programar interface quando for agrega-la no script principal

# exti=0

# while [$exti -ne 1]; do
#     echo " "
#     echo "Escolha o banco de dados para instalar:"
#     echo "1. MariaDB"
#     echo "2. PostgreSQL"
#     echo "3. MySQL"
#     echo "0. Finalizar instalações"
#     read -p "Digite o número correspondente à sua escolha: " CHOICE


#     case $CHOICE in
#         1)
#             install_mariadb_container
#             ;;
#         2)
#             install_postgresql_container
#             ;;
#         3)
#             install_mysql_container
#             ;;
#         0)
#             exti=1
#             echo "Saindo..."
#             ;;
#         *)
#             echo "Escolha inválida"
#             ;;
#     esac
# done