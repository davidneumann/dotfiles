# Windows

1. [Install scoop](https://scoop.sh/)
2. Install git

- `scoop install git`

3. Clone repo

- `git clone https://github.com/davidneumann/dotfiles Source\dotfiles`

4. Run the install script in dotfiles

- `.\install.ps1`

5. Go clone [lazyvim](https://github.com/davidneumann/lazyvim-setup) to `%appdata%\local\nvim`

- `git clone https://github.com/davidneumann/lazyvim-setup.git $Env:LOCALAPPDATA\nvim`

6. Install neovim

- `scoop bucket add main`
- `scoop install neovim`
- `scoop install extras/vcredist2022`

7. Install WSL

- `wsl --install`

8. Reboot

9. Follow Linux install

# Linux

idk lol
