{ config, pkgs, ... }:
let
  homeDir = builtins.getEnv "HOME";
in
{
  imports = [
    ../nvim-nix/nix
    ./tmux.nix
  ];

  xdg.mime.enable = true;
  targets.genericLinux.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  # Allow unfree
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  programs.neovim = {
    enable = true;
    withNodeJs = true;
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # pkgs.neovim
    pkgs.lua-language-server
    pkgs.fzf
    pkgs.ripgrep
    pkgs.unzip
    pkgs.go
    pkgs.zig
    pkgs.vim
    pkgs.google-chrome
    pkgs.wezterm
    pkgs.obsidian
    pkgs.lazygit
    pkgs.yazi
    pkgs.nodejs

    pkgs.noto-fonts
    pkgs.noto-fonts-cjk
    pkgs.noto-fonts-emoji
    pkgs.liberation_ttf
    pkgs.fira-code
    pkgs.fira-code-symbols
    pkgs.mplus-outline-fonts.githubRelease
    pkgs.dina-font
    # pkgs.proggyfonts
    (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; })

    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/wezterm/wezterm.lua".source = "${homeDir}/system/dotfiles/wezterm/wezterm.lua";
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/system/nvim-nix/nvim";
    ".zshrc".source = "${homeDir}/system/dotfiles/zsh/zshrc";
    ".xprofile".source = "${homeDir}/system/dotfiles/xprofile";
    ".config/zsh/per-directory-history.zsh".source = "${homeDir}/system/dotfiles/zsh/per-directory-history.zsh";
    # ".config/tmux/tmux.conf".source = "${homeDir}/system/dotfiles/tmuxconf/tmux.conf";
    ".config/tmux/tmux-cht-languages".source = "${homeDir}/system/dotfiles/tmuxconf/tmux-cht-languages";
    ".config/tmux/tmux-cht-command".source = "${homeDir}/system/dotfiles/tmuxconf/tmux-cht-command";
    ".config/nvim-old".source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/system/nvim-2025";

    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    settings = builtins.fromJSON (
      builtins.unsafeDiscardStringContext (builtins.readFile "${homeDir}/system/dotfiles/myposh.omp.json")
    );
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/david/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bash.enable = true;
}
