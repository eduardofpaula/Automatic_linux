#!/bin/bash

# Script de configuração do Pop!_OS
# Autor: Eduardo Farias
# Data: $(date)

# Este script configura um sistema Pop!_OS com ferramentas básicas e aplicativos essenciais.
# Ele instala ferramentas de desenvolvimento, configura o ambiente e instala aplicativos via Flatpak.

set -e  # Interrompe o script em caso de erro

echo "🛠️ Iniciando configuração do Pop!_OS..."

# Verifica se o sistema é Pop!_OS (ou Ubuntu-based)
if ! grep -qi "pop" /etc/os-release; then
    echo "❌ Este script foi feito para Pop!_OS. Sistema atual não suportado."
    exit 1
fi

# Adicionar repositórios PPA separadamente
echo "📦 Adicionando repositórios PPA..."
sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch

# Atualizar o sistema
echo "🔄 Atualizando repositórios e pacotes do sistema..."
sudo apt update && sudo apt upgrade -y

# Instalar pacotes básicos
echo "📦 Instalando pacotes básicos..."
sudo apt install -y git curl wget unzip htop fastfetch software-properties-common apt-transport-https

# Instalar Zsh, GNOME Tweaks e Flatpak
sudo apt install -y zsh gnome-tweaks flatpak

# Instalar ferramentas de desenvolvimento (gcc, g++, make, cmake)
sudo apt install -y build-essential cmake

# Instalar Python 3 e pip
sudo apt install -y python3 python3-pip

# Instalar Java 21 (JDK inclui a JRE e ferramentas de compilação)
sudo apt install -y openjdk-21-jdk

# Instalar Node.js e Go
sudo apt install -y nodejs golang

# Configurar GOPATH
echo "🔧 Configurando Go..."
mkdir -p "$HOME/go"
if ! grep -q "GOPATH" "$HOME/.bashrc"; then
    echo 'export GOPATH=$HOME/go' >> "$HOME/.bashrc"
    echo 'export PATH=$PATH:$GOPATH/bin' >> "$HOME/.bashrc"
fi

# Configurar Flatpak e instalar apps
# Adicionar repositório Flathub (Pop!_OS já vem com Flatpak, mas é bom garantir o flathub)
sudo flatpak remote-add --system --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Lista de apps Flatpak para instalar
declare -a flatpak_apps=(
    "com.stremio.Stremio"
    "com.discordapp.Discord"
    "com.spotify.Client" 
    "com.mattjakeman.ExtensionManager"
    "io.github.flattool.Warehouse"
    "org.videolan.VLC"
    "md.obsidian.Obsidian"
    "io.dbeaver.DBeaverCommunity"
    "rest.insomnia.Insomnia"
    "com.jetbrains.IntelliJ-IDEA-Ultimate"
    "com.jetbrains.PyCharm-Professional"
    "me.iepure.devtoolbox"
    "io.github.giantpinkrobots.varia"
)

echo "📦 Instalando apps via Flatpak..."
for app in "${flatpak_apps[@]}"; do
    echo "  Instalando $app..."
    sudo flatpak install --system --noninteractive -y flathub "$app" || echo "  ⚠️ Falha ao instalar $app"
done

# Instalar Visual Studio Code via repositório APT oficial da Microsoft
echo "🖥️ Instalando Visual Studio Code..."
curl -fSsL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/vscode-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/vscode-archive-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
sudo apt update
sudo apt install -y code

# Instalar Docker via repositório oficial para Ubuntu/Pop!_OS
echo "🐳 Instalando Docker..."
# Remover versões antigas do Docker caso existam
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove -y $pkg || true; done

# Adicionar chave GPG oficial do Docker
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Configurar o repositório do Docker pegando o codinome da base Ubuntu do Pop!_OS
. /etc/os-release
UBUNTU_CODENAME=${UBUNTU_CODENAME:-$VERSION_CODENAME}
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $UBUNTU_CODENAME stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable --now docker

# Adicionar usuário ao grupo docker se não estiver já
if ! groups "$USER" | grep -q docker; then
    sudo groupadd -f docker || true
    sudo usermod -aG docker "$USER"
    echo "  👤 Usuário $USER adicionado ao grupo docker"
fi

# Instalar Lazydocker
echo "🐳 Instalando Lazydocker..."
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# Git config
echo "🔧 Configurando Git..."

git_name=""
while [ -z "$git_name" ]; do
    read -p "Digite seu nome para o Git: " git_name
done

git_email=""
while [ -z "$git_email" ]; do
    read -p "Digite seu email para o Git: " git_email
done

git config --global user.name "$git_name"
git config --global user.email "$git_email"
git config --global init.defaultBranch main

echo "📝 Configurações aplicadas:"
echo "  Nome: $git_name"
echo "  Email: $git_email"

git config --list --show-origin

# Limpar pacotes desnecessários
echo "🧹 Limpando o sistema..."
sudo apt autoremove -y

echo "✅ Setup concluído! Reinicie o sistema ou faça logout para aplicar todas as permissões (especialmente do Docker) e variáveis."