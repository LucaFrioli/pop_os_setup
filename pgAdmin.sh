#!/bin/bash
### Temp

function apt_update() {
  echo "Atualizando repositórios apt ..."
  sudo apt update

  echo "Repositórios atualizados com êxito, pressione qualquer tecla para continuar :"
  read -n 1 -s
}

function apt_update_upgrade() {
  apt_update

  echo "Atualizando pacotes apt ..."
  sudo apt upgrade -y

  echo "Pacotes atualizados com êxito, pressione qualquer tecla para continuar :"
  read -n 1 -s
}

### Temp

### Melhorar a interação entre as funções

# Funções relacionadas ao pgAdmin 4

function install_pgadmin4() {
  echo "Verificando se o pgAdmin 4 já está instalado..."
  if dpkg -s pgadmin4 &>/dev/null; then
    echo "pgAdmin 4 já está instalado."
    read -n 1 -s
    return 0 # Sucesso, pgAdmin já instalado
  elif command -v pgadmin4 >/dev/null 2>&1; then
    echo "pgAdmin 4 parece estar instalado (possivelmente de outra forma), mas não gerenciado pelo APT."
    read -n 1 -s
    return 0 # Sucesso, pgAdmin instalado por outro método
  fi

  echo "Instalando pgAdmin 4..."

  # Atualiza repositórios antes da instalação
  apt_update

  echo "Adicionando chave GPG do pgAdmin..."
  curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
  if [[ $? -ne 0 ]]; then
    echo "Erro ao importar a chave GPG."
    read -n 1 -s
    return 1
  fi

  echo "Adicionando repositório do pgAdmin..."
  echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" | sudo tee /etc/apt/sources.list.d/pgadmin4.list
  if [[ $? -ne 0 ]]; then
    echo "Erro ao adicionar o repositório."
    read -n 1 -s
    return 1
  fi

  apt_update

  echo "Instalando o pacote pgadmin4..."
  sudo apt install pgadmin4 -y
  if [[ $? -ne 0 ]]; then
    echo "Erro ao instalar o pgAdmin 4."
    read -n 1 -s
    return 1
  fi

  echo "pgAdmin 4 instalado com sucesso."
  read -n 1 -s
  return 0
}

function uninstall_pgadmin4() {
  echo "Verificando se o pgAdmin 4 está instalado..."
  if ! dpkg -s pgadmin4 &>/dev/null; then
    echo "pgAdmin 4 não está instalado."
    read -n 1 -s
    return 0 # Sucesso, pgAdmin não está instalado
  fi

  echo "Desinstalando pgAdmin 4..."

  sudo apt purge --auto-remove pgadmin4 -y
  if [[ $? -ne 0 ]]; then
    echo "Erro ao desinstalar o pgAdmin 4."
    read -n 1 -s
    return 1
  fi
  sudo rm /etc/apt/sources.list.d/pgadmin4.list
  apt_update
  echo "pgAdmin 4 desinstalado com sucesso."
  read -n 1 -s
  return 0
}

function check_pgadmin4_dependencies() {
  echo "Verificando dependências do pgAdmin 4..."
  if ! command -v curl &>/dev/null; then
    echo "Dependência 'curl' não instalada."
    return 1
  fi

  if ! command -v apt &>/dev/null; then
    echo "Dependência 'apt' não encontrada. (Sistema não baseado em Debian/Ubuntu?)"
    return 1
  fi

  if ! command -v gpg &>/dev/null; then
    echo "Dependência 'gpg' não instalada."
    return 1
  fi

  echo "Todas as dependências necessárias (curl, apt, gpg) parecem estar instaladas."
  return 0
}

check_pgadmin4_dependencies
uninstall_pgadmin4
install_pgadmin4
