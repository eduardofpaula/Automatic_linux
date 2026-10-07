# 🚀 Automatic Scripts

Scripts automatizados para instalação de ferramentas e aplicativos essenciais em diversos sistemas operacionais.

## Sobre o Projeto

Este repositório foi criado especialmente para profissionais que constantemente precisam formatar seus computadores ou configurar novos ambientes de desenvolvimento. O objetivo é automatizar todo o processo de instalação e configuração das ferramentas mais utilizadas no dia a dia.

## Objetivo

- ⚡ Acelerar o processo de configuração de um sistema novo
- 🔧 Padronizar ambientes de desenvolvimento
- 💼 Facilitar a vida de profissionais que lidam com múltiplas máquinas
- 🚀 Automatizar instalações repetitivas

## Sistemas Suportados

- ![Fedora](https://img.shields.io/badge/Fedora-294172?style=for-the-badge&logo=fedora&logoColor=white) - ✅
- ![Pop!_OS](https://img.shields.io/badge/Pop!_OS-48B9C7?style=for-the-badge&logo=pop-os&logoColor=white) - ✅
- ![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white) - 🔄

## O que é instalado?

**Pacotes e Ferramentas Básicas CLI:**
- Git, Curl, Wget, Unzip, Htop, Fastfetch
- Zsh, GNOME Tweaks, Flatpak
- apt-transport-https, software-properties-common

**Linguagens e Ferramentas de Desenvolvimento:**
- Build-essential (gcc, g++, make), CMake
- Python 3 e Pip
- Java 21 (OpenJDK)
- Node.js
- Go

**Containers:**
- Docker (CE, CLI, Compose, Buildx)
- Lazydocker

**Aplicativos Flatpak:**
- **Desenvolvimento e Produtividade:** DBeaver Community, Insomnia, IntelliJ IDEA Ultimate, PyCharm Professional, Obsidian, DevToolbox.
- **Multimídia e Comunicação:** Stremio, Discord, Spotify, VLC.
- **Utilitários:** ExtensionManager, Warehouse, Varia.

**Repositórios:**
- Flathub (Aplicativos em Flatpak)
- Microsoft (Visual Studio Code)
- Docker (Docker Engine, CLI e Plugins)

## Como Usar

1. **Clone o repositório:**
   ```bash
   git clone [https://github.com/eduardofpaula/Automatic_scripts.git](https://github.com/eduardofpaula/Automatic_scripts.git)
   cd Automatic_scripts
   ```

2. **Escolha o script correspondente à sua distribuição e torne-o executável:**
   *(O exemplo abaixo usa o script do Pop!_OS, altere para o da sua distro caso necessário)*
   ```bash
   chmod +x linux/popos-setup.sh
   ```

3. **Execute o script escolhido:**
   ```bash
   ./linux/popos-setup.sh
   ```

4. **Siga as instruções na tela para configurar Git e outras opções personalizáveis.**

5. **Reinicie o sistema após a conclusão para aplicar todas as configurações.**

## ⚠️ Importante

- ⚡ **Execute com cuidado:** Os scripts fazem alterações significativas no sistema
- 🔒 **Sudo necessário:** Alguns comandos requerem privilégios administrativos
- 💾 **Backup recomendado:** Faça backup de configurações importantes antes de executar
- 🔄 **Reinicialização:** Reinicie o sistema após a execução para aplicar todas as mudanças (especialmente permissões de grupo do Docker).

## 🤝 Contribuições

Contribuições são sempre muito bem-vindas! Sinta-se à vontade para abrir *Issues* relatando bugs ou sugerindo melhorias, e para enviar *Pull Requests* com novos scripts para outros sistemas operacionais ou aperfeiçoar os já existentes.

## 👤 Autor

**Eduardo Farias**
- GitHub: [@eduardofpaula](https://github.com/eduardofpaula)
- Email: eduardo.fariasp@outlook.com

---

⭐ **Se este projeto foi útil para você, deixe uma estrela!** ⭐
