{ pkgs, ... }:
let
  owner = "andreaskrath";
  repo = "justfiles";
  branch = "master";
in
{
  home.packages = with pkgs; [
    curl
    (import /etc/nixos/home/zsh/scripts/setup_env.nix { inherit pkgs; })
    lazygit
    bat
  ];
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      xo = "xdg-open";
      ll = "ls -l";
      la = "ls -A";
      cat = "${pkgs.bat}/bin/bat";
      ".." = "cd ../";
      "...." = "cd ../../";
      "......" = "cd ../../../";
      switch = "sudo nixos-rebuild switch";
      boot = "sudo nixos-rebuild boot";
      lg = "${pkgs.lazygit}/bin/lazygit";
    };

    initExtra = ''
      eval "$(direnv hook zsh)"

      # a function to fetch a justfile for a given language based on the first argument
      just_get() {
        lang=$1

        if [ -z "$1" ]; then
          echo "Please specify the language of the justfile you are interested in getting."
          return 1
        fi
        
        repo_url="https://raw.githubusercontent.com/${owner}/${repo}/${branch}/$lang/justfile"

        content=$(${pkgs.curl}/bin/curl -s $repo_url)

        if [ $? -eq 0 ]; then
          echo "$content" > justfile
          echo "Fetched $lang justfile and saved as 'justfile'."
          echo "Make sure to check the contents of the justfile, and make appropriate modifications if necessary:"
          ${pkgs.bat}/bin/bat justfile        
        else
          echo "Could not fetch $lang justfile from the repository. Ensure that '$lang' is spelled correctly and matches a justfile in the repository."
        fi
      }
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };
}
