{...}: {
  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;
    clientMaxBodySize = "500m";

    virtualHosts = {
      "www.datamagikeren.dk" = {
        forceSSL = true;
        enableACME = true;

        locations."/" = {
          return = "301 https://www.youtube.com/watch?v=dQw4w9WgXcQ"; # rick roll for the time being
        };
      };

      "datamagikeren.dk" = {
        forceSSL = true;
        enableACME = true;
        globalRedirect = "www.datamagikeren.dk";
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "andreas.krath@gmail.com";
    };
  };
}
