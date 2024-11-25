# Pop!_os setup

- [Documentation in english](#en)
- [Documentação em português](#pt-br)
- [Documentazione in italiano](#it)

---

## **EN:**

**NOTE: The script is intended for the first setup of recently formatted machines or machines with a newly installed system. If this script is run in production environments, it may result in the loss of Docker containers and downtime of active NodeJS servers.**

This repository is a pre-configuration for Ubuntu-based systems. In this case, it was created with Pop_os in mind. It aims to facilitate the installation of basic development tools and languages. This script is completely opinionated for my workflow. It is intended only to be run on systems that have been recently formatted or a newly installed system.

The script aims to install development languages ​​and tools, as well as utilities for the operating system. The idea is to produce as quickly as possible after the operating system installation. It is not 100% automated, however, as it aims to install the tools and make it very clear to the user what is happening.

Here is a list of what the script will be installing. The list consists of the bibliography I used for inspiration and installation techniques for each software, and its documentation below.

- [See the list of programs, tools and languages ​​installed with this script](#installed-programs-and-languages--programas-e-linguagens-instalados--programmi-e-lingue-installati)

---

## **PT-BR:**

**NOTA: O script é destinado à primeira configuração de máquinas recentemente formatadas ou com um sistema recém-instalado. Se este script for executado em ambientes de produção, pode resultar na perda de contêineres Docker e no tempo de inatividade de servidores NodeJS ativos.**

Este repositório é uma pré-configuração para sistemas baseados em Ubuntu. Neste caso, ele foi criado com o Pop_os em mente. Ele visa facilitar a instalação de ferramentas e linguagens básicas para desenvolvimento. Este script é completamente opinativo para meu fluxo de trabalho. Destinado apenas à execução em sistemas que foram recentemente formatados ou sistema recém-instalados.

O script tem como objetivo, instalar linguagens e ferramentas de desenvolvimento, assim como utilitários para o sistema operacional. A ideia é produzir o mais rápido possível após a instalação do sistema operacional. Ele só não é 100% automatizado, pois visa além de instalar as ferramentas, deixar bem claro ao usuário o que está ocorrendo.

Segue uma lista do que o script estará instalando. A lista consiste na bibliografia que utilizei para inspiração e técnica de instalação de cada um dos softwares, e sua documentação logo em seguida.

- [Veja a lista de programas, ferramentas e linguagens instalados com este script](#installed-programs-and-languages--programas-e-linguagens-instalados--programmi-e-lingue-installati)

---

## **IT:**

**NOTA: Lo script è destinato alla prima configurazione su macchine appena formattate o con un sistema appena configurati. Se questo script viene eseguito in ambienti di produzione, potrebbe causare la perdita dei "containers" Docker e tempi di inattività dei server NodeJS attivi.**

Questo "repository" è una preconfigurazione per i sistemi basati su Ubuntu, creata pensando a Pop!_os, con lo scopo di facilitare l'istallazione di strumenti e linguaggi di base per lo sviluppo. Questo script è stato completamente creato sulla base del mio flusso di lavoro, destinato solo all'esecuzione su sistemi che siano stati formattati di recente o su sistemi appena istallati.

Lo script mira ad istallare linguaggi e strumenti di sviluppo, nonché "utilities" per il sistema operativo. L'idea è di essere produttivo il più rapidamente possibile dopo aver configurato il sistema operativo. Semplicemente non è automatizzato al 100%, poiché mira, oltre a impostare gli strumenti, a rendere molto chiaro all'utente cosa stia succedendo.

Di seguito è riportato un elenco di tutto ciò che verrà istallato dallo script. L'elenco è costituito dalla bibliografia che ho utilizzato come ispirazione per le tecniche di implementazione per ciascuno dei software e della relativa documentazione.

- [Vedere l'elenco dei programmi, strumenti e linguaggi installati con questo script](#installed-programs-and-languages--programas-e-linguagens-instalados--programmi-e-lingue-installati)

---

## Installed programs and languages / Programas e linguagens instalados / Programmi e lingue installati

**EN: Below is a list of tools that are being installed. Click on each one to be redirected to the page where they are being installed, and to docs for their documentation.**

**PT-BR: Segue a lista de ferramentas que estão sendo instaladas. Clique em cada uma delas para ser redirecionado para a página de onde elas estarão sendo instaladas, e em docs para suas documentações.**

**IT: Di seguito è riportato l'elenco degli strumenti in fase di istallazione. Fai clic su ciascuno di essi per essere reindirizzato alla pagina in cui vengono configurati e ai relativi docs per la documentazione.**

- [**Snap**](https://snapcraft.io/docs/installing-snap-on-pop): [docs](https://snapcraft.io/docs)
- [**Nix**](https://nixos.org/download/): [docs](https://nix.dev/manual/nix/2.18/)
- [**Flatpak**](https://flatpak.org/setup/Pop!_OS): [docs](https://docs.flatpak.org/en/latest/introduction.html)
- [**Nvm**](https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating): [docs](https://github.com/nvm-sh/nvm/blob/master/README.md)
- **NodeJs**(EG: note: installed via nvm. PT-BR: obs: instalado via nvm. IT: nota: istallato tramite nvm): [docs](https://nodejs.org/pt/learn/getting-started/introduction-to-nodejs)
- [**Rust**](https://doc.rust-lang.org/book/ch01-01-installation.html): [docs](https://doc.rust-lang.org/book/title-page.html)
- [**Docker**](https://docs.docker.com/desktop/setup/install/linux/ubuntu/): [docs](https://docs.docker.com/?_gl=1*14yltxd*_gcl_au*ODcyNDA1Njk2LjE3MzI1NTUwMTA.*_ga*OTk2MjY3MTM3LjE3MzI1NTM2MDY.*_ga_XJWPQMJYHQ*MTczMjU1MzYwNS4xLjEuMTczMjU1NTAxMi41OC4wLjA.)
- [**Visual Studio Code**](https://snapcraft.io/code): [docs](https://code.visualstudio.com/docs)
- [**Mysql Workbench Community**](https://snapcraft.io/mysql-workbench-community): [docs](https://dev.mysql.com/doc/workbench/en/)
- [**Insomnia**](https://flathub.org/apps/rest.insomnia.Insomnia): [docs](https://docs.insomnia.rest/insomnia/get-started)
- [**Google Chrome**](https://flathub.org/apps/com.google.Chrome): [docs](https://developer.chrome.com/docs?hl=pt-br)
- [**GParted**](https://gparted.org/download.php): [docs](https://gparted.org/documentation.php)
- [**Timeshift**](https://github.com/teejee2008/timeshift)
- [**Htop**](https://htop.dev/downloads.html): [docs](https://github.com/htop-dev/htop/blob/main/README.md)
- [**Neofetch**](https://github.com/dylanaraps/neofetch/wiki/Installation): [docs](https://github.com/dylanaraps/neofetch/wiki)
