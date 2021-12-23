#ensure .bashrc is read
grep -qxF  "if [ -f ~/.bashrc ]; then . ~/.bashrc; fi" ~/.bash_profile || echo "if [ -f ~/.bashrc ]; then . ~/.bashrc; fi" >> ~/.bash_profile

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
    echo "Installing Meslo font"
    curl --silent -L "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip" -o /tmp/meslo.zip
    unzip -o -a /tmp/meslo.zip -d /tmp/fonts/ > /dev/null
    font_dir="$HOME/Library/Fonts"
    find "/tmp/fonts/" \( -name "*.[ot]tf" -or -name "*.pcf.gz" \) -type f -print0 | xargs -0 -n1 -I % cp "%" "$font_dir/"
    rm -rf /tmp/meslo.zip
    rm -rf /tmp/fonts
fi
if ! command -v oh-my-posh  &> /dev/null
then
    echo "Installing oh-my-posh"
    brew tap jandedobbeleer/oh-my-posh
    brew install oh-my-posh
fi
if command -v oh-my-posh &> /dev/null
then
    posh_theme="myposh.omp.json"
    if [ ! -e "$HOME/$posh_theme" ]; then
        ln -s $(pwd)/$posh_theme ~/$posh_theme
    fi
    posh_string='eval "$(oh-my-posh --init --shell bash --config ~/'"$posh_theme"')"'
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