{ ... }:
{
  # adds signature to all git commits
  home.file.".ssh/allowed_signers".text = "* ${builtins.readFile /home/krath/.ssh/id_ed25519.pub}";

  programs.git = {
    enable = true;
    userName = "Andreas Krath";
    userEmail = "andreas.krath+github@gmail.com";

    extraConfig = {
      commit.gpgsign = true; # sign all commits using ssh key
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };
}