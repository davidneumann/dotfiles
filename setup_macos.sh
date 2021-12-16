#Setup zsh or bash completions
if [[ $OSTYPE == 'darwin'* ]]; then
    echo "Enabling Ctrl + Cmd + Click window drag"
    defaults write -g NSWindowShouldDragOnGesture -bool true

    if [[ $SHELL == '/bin/zsh' ]]; then
        echo "Setting up fancy comnpletions for zsh"
        autoload -Uz compinit && compinit
        # git clone "https://github.com/scriptingosx/mac-zsh-completions.git" deps/mac-zsh-completions/
        # echo "fpath=( ~/Projects/mac-zsh-completions/completions $fpath )" >> ~/.zshrc
    elif [[ $SHELL == '/bin/bash' ]]; then
        echo "Setting up fancy completions for bash"
        brew install bash-completion

        echo "Ensure ls is colorful"
        if [ -e "$HOME/.bashrc" ]; then
            grep -qxF "alias ls='ls -G'" ~/.bashrc || echo "alias ls='ls -G'" >> ~/.bashrc
        else
            echo "alias ls='ls -G'" >> ~/.bashrc
        fi
    fi
fi