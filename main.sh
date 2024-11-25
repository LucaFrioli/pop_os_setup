#!/bin/bash

#### comando de espera read -n 1 -s

function apt_update(){
    echo "Atualizando repositórios apt ..."   
    sudo apt update
   
    echo "Repositórios atualizados com êxito, pressione qualquer tecla para continuar :"
    read -n 1 -s
}

function apt_update_upgrade(){
    apt_update 
    
    echo "Atualizando pacotes apt ..." 
    sudo apt upgrade -y 
    
    echo "Pacotes atualizados com êxito, pressione qualquer tecla para continuar :"
    read -n 1 -s
}


function add_curl(){
    apt_update

    if ! command -v curl &> /dev/null ; then
        echo "Instalando curl ..."
        sudo apt install curl

        if command -v curl &> /dev/null ; then
            curl --version
            echo "Curl instalado com êxito, pressione qualquer tecla para continuar :"
            read -n 1 -s
        else
            echo "Erro ao instalar Curl ! Pressione qualquer tecla para continuar: "
            read -n 1 -s
        fi

        apt_update
    else
        echo "curl já instalado !"
        curl --version
        echo "Pressione qualquer tecla para continuar: "
        read -n 1 -s
    fi
}

function add_flatpak(){
    apt_update

    if ! command -v flatpak &> /dev/null; then
        echo "Instalando flatpak ..."
        sudo apt install flatpak
        flatpak --version
        
        if command -v flatpak &> /dev/null; then
            echo "Adicionando flathub ..."
            flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

            echo "Repositórios adicionados com êxito, pressione qualquer tecla para continuar: "
            read -n 1 -s
        else
            echo "Erro ao instalar o flatpak ! Pressione qualquer tecla para continuar: "
            read -n 1 -s
        fi
    else
        echo "flatpak já instalado !"
        flatpak --version
        echo "Pressione qualquer tecla para continuar: "
        read -n 1 -s
    fi
}

function add_snap(){
    apt_update

    if ! command -v snap &> /dev/null; then
        echo "Instalando snap ..."
        sudo apt install snapd

        if command -v snap &> /dev/null; then
            snap --version
            echo "Snap instalado com êxito, pressione qualquer tecla para continuar: "
            read -n 1 -s
        fi

        apt_update
    else
        echo "Snap Já instalado !"
        snap --version
        
        echo "Pressione qualquer tecla para continuar: "
        read -n 1 -s
    fi
}

function add_nix(){
    if ! command -v nix &>/dev/null; then
        sh <(curl -L https://nixos.org/nix/install) --daemon
        if command -v nix &> /dev/null; then
            echo "Nix instalado com êxito: "
            nix --version
            echo "Pressione qualquer tecla para continuar: "
            read -n 1 -s
        else
            echo "Erro ao tentar instalar o nix! Pressione qualquer tecla para continuar: "
            read -n 1 -s
        fi
    else
        echo "Nix já instalado:"
        nix --version
        echo "Pressione qualquer tecla para continuar: "
        read -n 1 -s
    fi
}


function remove_node() {

  echo "Removendo o nodeJS ... "
  if [ -d "/usr/local/bin/node" ]; then
    
    sudo apt purge --auto-remove nodejs -y
    sudo rm /etc/apt/sources.list.d/nodesource.list*

    echo "Node.js removido com sucesso! Pressione qualquer tecla para continuar: "
    read -n 1 -s

    apt_update
  else
    echo "O Node.js não está instalado. Pressione qualquer tecla para continuar: "
    read -n 1 -s
  fi
}

function remove_nvm() {
  
  echo "Removendo o NVM..."
  if [ -d "$HOME/.nvm" ]; then
    rm -rf "$HOME/.nvm"

    sed -i '/nvm/d' "$HOME/.bashrc"
    sed -i '/nvm/d' "$HOME/.zshrc"

    echo "NVM removido com sucesso! Pressione qualquer tecla para continuar: "
    read -n 1 -s

    apt_update
  else
    echo "O NVM não está instalado. Pressione qualquer tecla para continuar: "
    read -n 1 -s
  fi
}

function remove_rust(){
    
    echo "Removendo rust ..."
    if command -v rustup; then
        rustup self uninstall
        echo "Rust removido com sucesso!Pressione qualquer tecla para continuar: "
        read -n 1 -s 

        apt_update
    else
        echo "Rust não está instalado.Pressione qualquer tecla para continuar: "
        read -n 1 -s
    fi
}

function remove_docker(){
    echo "Removendo Docker ..."
    if command -v docker; then
        sudo apt-get remove --purge \
        docker \
        docker-engine \
        docker.io \
        containerd runc -y
        echo "Se existiam versões do docker antigas elas foram removidas, pressione qualquer tecla para continuar :"
        read -n 1 -s

        apt_update
    else
        echo "Docker não instalado, pressione qualquer tecla para continuar: "
        read -n 1 -s
    fi
}


function install_nvm(){
    echo "Instalando nvm ..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  

   if command -v nvm; then
        echo "Nvm instalada com êxito: "
        nvm --version
        
        echo "Pressione qualquer tecla para inciar a instalação da versão lts do node: "
        read -n 1 -s

        echo "Instalando a versão do node lts ..."
        nvm install --lts 
        
        if command -v node && command -v npm; then
            echo "Node instalado com êxito: "
            node --version && npm --version
            echo "Pressione qualquer tecla para continuar:"
            read -n 1 -s
        else
            echo "Algum erro ocorreu ao tentar instalar o node, após o término da execução do script averigue."
        fi
   else
        echo "Erro ao instalar a nvm"
   fi

   echo "Pressione qualquer tecla para continuar: "
   read -n 1 -s
}

function install_rust(){

    echo "Instalando rust ..."
    if ! command -v rustup; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        
        if command -v rustc; then
            echo "Rust instalado com êxito"
            echo "Versões instaladas :"
            rustup --version
            rustc --version
            cargo --version
        else
            echo "Erro ao instalar Rust. Verifique o processo manualmente."
            
        fi
    else
        echo "Rustup já instalado."
    fi
    
    echo "Pressione qualquer tecla para continuar: "
    read -n 1 -s
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
}

function install_mysql_workbench(){

    if ! command -v snap &> /dev/null; then
        echo "Snap não está disponível, instalando Snap... "
        add_snap
    fi

    echo "Instalando o MySQL Workbench, isso pode levar alguns minutos ..."
    if ! command -v mysql-workbench-community &> /dev/null; then
        sudo snap install mysql-workbench-community

        if command -v mysql-workbench-community &> /dev/null; then
            snap info mysql-workbench-community
            echo "MySQL Workbench instalado com êxito."
        else
            echo "Falha ao instalar Mysql workbench Community !"
        fi
    else
        echo "MySQL Workbench Community está instalado."
    fi

    echo "Pressione qualquer tecla para continuar :"
    read -n 1 -s
}

function install_vscode(){

    if ! command -v snap &> /dev/null; then
        echo "Snap não está disponível, instalando Snap... "
        add_snap
    fi

    echo "Instalando Visual Studio Code, aguarde isso pode levar alguns minutos ..."
    if ! command -v code &> /dev/null; then

        sudo snap install code --classic

        if command -v code &> /dev/null; then
            echo "Visual Studio code instalado com êxito:"
            snap info code
        else
            echo "Falha ao instalar o Visual Studio Code."
        fi

    else
        echo "Visual Studio Code já está instalado."
    fi
    echo "Pressione qualquer tecla para continuar:"
    read -n 1 -s
}

function install_insomnia(){

    if ! command -v flatpak &> /dev/null; then
        echo "Flatpak não está disponível, instalando Flatpak... "
        add_flatpak
    fi

    echo "Instalando Insomnia ..."
    if ! flatpak list | grep -q rest.insomnia.Insomnia; then
        flatpak install flathub rest.insomnia.Insomnia
        if flatpak list | grep -q rest.insomnia.Insomnia; then
            echo "Insomnia instalado com êxito"
            flatpak info rest.insomnia.Insomnia 
        else
            echo "Erro na instalação do Insomnia. Verifique manualmente após a conclusão do script."
        fi
    else
        echo "Insomnia já está instalado."
    fi

    echo "Pressione qualquer tecla para continuar :"
    read -n 1 -s
}

function install_chrome(){
    
    if ! command -v flatpak &> /dev/null; then
        echo "Flatpak não está disponível, instalando Flatpak... "
        add_flatpak
    fi

    echo "Instalando google chrome ..."
    if ! flatpak list | grep -q com.google.Chrome; then
        flatpak install flathub com.google.Chrome

        if flatpak list | grep -q com.google.Chrome; then       
            echo "Goole Chrome instalado com êxito"
            flatpak info com.google.Chrome
        else
            echo "Erro na instalação do Google Chrome. Verifique manualmente após a conclusão do script"
        fi 
    else
        echo "Google Chrome já está instalado !"
    fi

    echo "pressione qualquer tecla para continuar :"
    read -n 1 -s
}

function install_tools() {
    local tools=("gparted" "timeshift" "htop" "neofetch")
    
    apt_update
    
    echo "Verificando ferramentas para instalação..."
    for tool in "${tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            echo "Instalando $tool..."
            sudo apt install -y "$tool"
            if command -v "$tool" &> /dev/null; then
                echo "$tool instalado com sucesso."
            else
                echo "Erro ao instalar $tool. Verifique manualmente."
            fi
        else
            echo "$tool já está instalado."
        fi
    done
    
    echo "As ferramentas utilitárias foram verificadas."
    echo "Pressione qualquer tecla para continuar..."
    read -n 1 -s
}



apt_update_upgrade
add_curl
add_snap
add_nix

apt_update_upgrade
remove_node
remove_nvm
remove_rust
remove_docker

apt_update_upgrade
install_rust
install_nvm
install_vscode
install_docker
install_insomnia
install_mysql_workbench
install_chrome
install_tools