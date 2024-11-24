#!/bin/bash

#### comando de espera read -n 1 -s

function apt_update(){
    sudo apt update
}

function apt_update_upgrade(){
    apt_update && sudo apt upgrade -y
}


function add_curl(){
    apt_update

    if ! command -v curl &> /dev/null ; then
        sudo apt install curl
        curl --version
        apt_update
    else
        echo "crul já instalado !"
        crul --version
    fi
}

function add_flatpak(){
    apt_update

    if ! command -v flatpak &> /dev/null; then
        sudo apt install flatpak
        flatpak --version
        
        if command -v flatpak &> /dev/null; then
            flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
        else
            echo "Erro ao instalar o flatpak !"
        fi
    else
        echo "flatpak já instalado !"
        flatpak --version
    fi
}

function add_snap(){
    apt_update

    if ! command -v snap &> /dev/null; then
        sudo apt install snapd
        snap --version
        apt_update
    else
        echo "Snap Já instalado !"
        snap --version
    fi
}

function add_nix(){
    sh <(curl -L https://nixos.org/nix/install) --daemon
    nix --version
}


function remove_node() {

  if [ -d "/usr/local/bin/node" ]; then

    sudo apt purge --auto-remove nodejs -y
    sudo rm /etc/apt/sources.list.d/nodesource.list*

    echo "Node.js removido com sucesso!"
    apt_update
  else
    echo "O Node.js não está instalado."
  fi
}

function remove_nvm() {

  if [ -d "$HOME/.nvm" ]; then
    rm -rf "$HOME/.nvm"

    sed -i '/nvm/d' "$HOME/.bashrc"
    sed -i '/nvm/d' "$HOME/.zshrc"

    echo "NVM removido com sucesso!"
    apt_update
  else
    echo "O NVM não está instalado."
  fi
}

function remove_rust(){
    if command -v rustup; then
        rustup self uninstall
        echo "Rust removido com sucesso!"
    else
        echo "Rust não está instalado."
    fi
}

function remove_docker(){
    sudo apt-get remove --purge \
    docker \
    docker-engine \
    docker.io \
    containerd runc -y
    echo "Se existiam versões do docker antigas elas foram removidas, pressione qualquer tecla para continuar :"
    read -n 1 -s

    # Atualiza a lista de pacotes
    apt_update
    echo "Atualização de reposítórios concluidas, pressione qualquer tecla para continuar :"
    read -n 1 -s
}


function install_nvm(){
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  

   if command -v nvm; then
        nvm --version
        echo "Instalando a verção do node lts"
        nvm install --lts && node --version && npm --version
   else
        echo "Erro ao instalar a nvm"
   fi
}

function install_rust(){

    if ! command -v rustup; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        rustup --version
        rustc --version
        cargo --version
    else
        echo "Erro ao instalar rust"
    fi
}

function install_docker(){
    # Instala dependências necessárias
    sudo apt install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        software-properties-common
    echo "Intalado dependências necessárias para a instalação do docker, pressione qualquer tecla para continuar :"
    read -n 1 -s

    # Adiciona a chave GPG do Docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "Adicionada chave do docker, pressione qualquer tecla para continuar :"
    read -n 1 -s

    # Adiciona o repositório do Docker
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    echo "Adicionado repositório do docker, pressione qualquer tecla para continuar :"
    read -n 1 -s

    # Atualiza a lista de pacotes novamente
    apt_update
    echo "Atualizando lista de repositórios, pressione qualquer tecla para continuar :"
    read -n 1 -s

    # Instala o Docker CE
    sudo apt install -y docker-ce docker-ce-cli containerd.io
    echo "Instalado os componentes do docker, agora iremos reiniciar o serviço e habilitar o docker na inicialização, pressione qualquer tecla para continuar :"
    read -n 1 -s

    # Garante a inicialização do docker
    sudo systemctl start docker

    # Reinicia o serviço do Docker
    sudo systemctl restart docker

    # Habilita o Docker para iniciar na inicialização
    sudo systemctl enable docker
    echo "Docker habilitado na inicialização do sistema, pressione qualquer tecla para continuar :"
    read -n 1 -s


    # Adiciona o usuário atual ao grupo docker
    sudo usermod -aG docker $USER

    # Verifica a versão do Docker
    docker --version
    echo "Docker instalado com êxito, pressione qualquer tecla para continuar :"
    read -n 1 -s

    # Passo 11: Atualiza a lista de pacotes e progrmas instalados
    apt_update_upgrade
    echo "Pacotes de repositórios atualizados com sucesso, pressione qualquer tecla para continuar :"
    read -n 1 -s
}

function install_mysql_workbench(){

    if ! command -v snap &> /dev/null; then
        echo "Snap não está disponível, instalando Snap... "
        add_snap
    fi

    if ! command -v mysql-workbench-community &> /dev/null; then
      echo "Iremos instalar o MySQL Workbench, pressione qualquer tecla e aguarde, isso pode levar alguns minutos!"
      read -n 1 -s
      # Instala o MySQL Workbench
      sudo snap install mysql-workbench-community
    else
      echo "MySQL Workbench Community está instalado, pressione qualquer tecla para continuar :"
      read -n 1 -s
    fi

    snap info mysql-workbench-community
    echo "MySQL Workbench instalado com êxito, pressione qualquer tecla para continuar :"
    read -n 1 -s
}

function install_vscode(){

    if ! command -v code; then
        curl -o vscode.deb https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
        sudo dpkg -i vscode.deb
        sudo apt --fix-broken install
    else
        echo "Visual Studio Code está instalado, pressione qualquer tecla para continuar :"
        read -n 1 -s
    fi
}

function install_insomnia(){

    if ! command -v flatpak &> /dev/null; then
        echo "Flatpak não está disponível, instalando Flatpak... "
        add_flatpak
    fi

    flatpak install flathub rest.insomnia.Insomnia
    
    flatpak info rest.insomnia.Insomnia 
    echo "Insomnia instalado com êxito, pressione qualquer tecla para continuar :"
    read -n 1 -s
}

function install_chrome(){
    
    if ! command -v flatpak &> /dev/null; then
        echo "Flatpak não está disponível, instalando Flatpak... "
        add_flatpak
    fi

    flatpak install flathub com.google.Chrome

    flatpak info com.google.Chrome 
    echo "Goole Chrome instalado com êxito, pressione qualquer tecla para continuar :"
    read -n 1 -s
}