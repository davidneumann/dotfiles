#Add helpful brew stuff
if ! command -v brew &> /dev/null
then
    echo "Installing brew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
brew tap homebrew/cask
if ! command -v git &> /dev/null
then
    echo "Installing git"
    brew install git
fi
if ! mdfind "kMDItemCFBundleIdentifier == com.googlecode.iterm2" &> /dev/null
then
    echo "Installing iterm2"
brew install --cask iterm2
fi

#Setup oh-my-posh
if ! fc-list | grep "Meslo" &> /dev/null
then
    here=$(pwd)
    echo "Installing Meslo font"
    # clone
    git clone https://github.com/powerline/fonts.git --depth=1 /tmp/fonts/
    # install
    cd /tmp/fonts/
    ./install.sh
    # clean-up a bit
    cd ..
    rm -rf fonts
    cd $here
fi
if ! command -v oh-my-posh  &> /dev/null
then
    echo "Installing oh-my-posh"
    brew tap jandedobbeleer/oh-my-posh
    brew install oh-my-posh
    cp /usr/local/opt/oh-my-posh/themes/emodipt.omp.json ~/
    posh_string='eval "$(oh-my-posh --init --shell bash --config ~/emodipt.omp.json)"'
    grep -qxF "$posh_string" ~/.bashrc || echo "$posh_string" >> ~/.bashrc
    . ~/.bashrc
fi

#Setup zsh or bash completions
if [[ $OSTYPE == 'darwin'* ]]; then
    echo "Enable subpixel antialiasing for bad montiors"
    defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
    defaults -currentHost write -globalDomain AppleFontSmoothing -int 2

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