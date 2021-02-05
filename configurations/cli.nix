{ config, pkgs, lib, ... }:
{

  programs.adb.enable = lib.mkDefault true;

  environment.variables = {
    EDITOR = "nvim";
    LC_ALL = "en_US.UTF-8";
    TERM = "xterm-256color";
  };

  environment.interactiveShellInit = ''
    source ${pkgs.zsh-forgit}/share/zsh-forgit/forgit.plugin.zsh
    ${builtins.readFile (pkgs.shell-config.override { dockerAliasEnabled = config.virtualisation.docker.enable; })}

    autoload -U promptinit; promptinit
    prompt pure
  '';

  programs.zsh = {
    autosuggestions.enable = true;
    enable = lib.mkDefault true;
    enableCompletion = true;
    histFile = "$HOME/.cache/.zsh_history";
    histSize = 100000;
    syntaxHighlighting.enable = true;
    ohMyZsh.enable = true;
    ohMyZsh.plugins = [ "sudo" "z" ];

    setOptions = [
      "noautomenu"
      "nomenucomplete"
      "AUTO_CD"
      "BANG_HIST"
      "EXTENDED_HISTORY"
      "HIST_EXPIRE_DUPS_FIRST"
      "HIST_FIND_NO_DUPS"
      "HIST_IGNORE_ALL_DUPS"
      "HIST_IGNORE_DUPS"
      "HIST_IGNORE_SPACE"
      "HIST_REDUCE_BLANKS"
      "HIST_SAVE_NO_DUPS"
      "INC_APPEND_HISTORY"
      "SHARE_HISTORY"
    ];

  };

  environment.shellAliases = {
    ga = "git add";
    gc = "git commit";
    gcm = "git commit -m";
    gs = "git status";
    gsb = "git status -sb";

    grep = "grep --color=auto";
    diff = "diff --color=auto";
    nixos-rebuild = "sudo nixos-rebuild";
    nix-repl = "source /etc/set-environment && nix repl $(echo $NIX_PATH | perl -pe 's|.*(/nix/store/.*-source/repl.nix).*|\\1|')";
    auto-nix-rebuild = "ls /etc/nixos/**/*.nix | entr sudo bash -c 'nixos-rebuild switch && printf \"DONE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n\"'";
    personal = "sudo $EDITOR /etc/nixos/personal.nix";
    opt = "manix '' | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --ansi --preview=\"manix '{}' | sed 's/type: /> type: /g' | bat -l Markdown --color=always --plain\"";

    burn = "pkill -9";
    external-ip = "dig +short myip.opendns.com @resolver1.opendns.com";
    f = "fd";
    v = "$EDITOR $(fzf)";
    sv = "sudo $EDITOR $(fzf)";
    killall = "pkill";
    q = "exit";
    sc = "sudo systemctl";
    scu = "systemctl --user ";
    svi = "sudo $EDITOR";
    net = "ip -c -br addr";

    cp = "cp -i";
    ln = "ln -i";
    mkdir = "mkdir -p";
    mv = "mv -i";
    rm = "rm -Iv --preserve-root";
    wget = "wget -c";

    c = "xclip -selection clipboard";
    cm = "xclip"; # Copy to middle click clipboard
    l = "ls -lF --time-style=long-iso";
    la = "l -a";
    ls = "exa -h --git --color=auto --group-directories-first -s extension";
    lstree = "ls --tree";
    tree = "lstree";

    ".." = "cd ..";
    "..." = "cd ../../";
    "...." = "cd ../../../";
    "....." = "cd ../../../../";
    "......" = "cd ../../../../../";
  };

  environment.systemPackages = with pkgs; [
    bat
    curl
    entr
    exa
    fd
    file
    fzf
    g-neovim
    git
    htop
    inetutils
    iotop
    jq
    lm_sensors
    lshw
    lsof
    man
    nettools
    nix-tree
    nix-top
    nixpkgs-fmt
    p7zip
    parted
    pciutils
    psmisc
    pure-prompt
    ranger
    ripgrep
    unzip
    wget
    which
    zip
  ];
}
