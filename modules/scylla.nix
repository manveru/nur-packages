{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.services.scylla;
in {
  options.services.scylla = with types; {
    enable = mkOption {
      type = bool;
      default = false;
      description = "Whether to enable the Scylla server.";
    };

    package = mkOption {
      type = package;
      default = pkgs.scylla;
      defaultText = "pkgs.scylla";
      description = "Which Scylla derivation to use.";
    };

    stateDir = mkOption {
      type = path;
      default = "/var/lib/scylla";
      description = "Used to clone and store build results.";
    };

    secretFile = mkOption {
      type = str;
      default = "/var/lib/scylla/secrets.env";
      description = ''
        This is the path to a shell script to source before running the server.
        Use this to export the GITHUB_USER and GITHUB_TOKEN environment variables.
      '';
    };

    user = mkOption {
      type = str;
      default = "scylla";
      description = "User account under which Scylla runs.";
    };

    bind = mkOption {
      type = nullOr str;
      default = null; # All interfaces
      description = "The IP interface to bind to.";
      example = "127.0.0.1";
    };

    port = mkOption {
      type = int;
      default = 7788;
    };

    openFirewall = mkOption {
      type = bool;
      default = true;
      description = ''
        Whether to open ports in the firewall for the server.
      '';
    };
  };

  config = mkIf cfg.enable {
    networking.firewall = mkIf cfg.openFirewall {
      allowedTCPPorts = [ cfg.port ];
    };

    users.users.scylla = {
      name = cfg.user;
      description = "Scylla CI user";
    };

    users.groups.scylla = {};

    systemd.services.scylla_init = {
      description = "Scylla server initialization";
      wantedBy = [ "scylla.service" ];
      before = [ "scylla.service" ];
      serviceConfig.Type = "oneshot";
      script = ''
        install -d -m0700 -o ${cfg.user} ${cfg.stateDir}
        chown -R ${cfg.user} ${cfg.stateDir}
      '';
    };

    systemd.services.scylla = rec {
      description = "Scylla Continuous Integration Service";

      path = with pkgs; [ git nix cfg.package ];

      environment = {
        PORT = builtins.toString cfg.port;
        HOST = cfg.bind;
        STATE_DIR = cfg.stateDir;
        GITHUB_USER = "${builtins.toString cfg.stateDir}/github_user";
        GITHUB_TOKEN = "${builtins.toString cfg.stateDir}/github_token";
      };

      preStart = ''
        source "${cfg.secretFile}"
        echo -n "$GITHUB_USER" > ${environment.GITHUB_USER}
        echo -n "$GITHUB_TOKEN" > ${environment.GITHUB_TOKEN}
      '';

      serviceConfig = {
        Restart = "always";
        RestartSec = 10;
        User = cfg.user;
        ExecStart = "${cfg.package}/bin/scylla";
      };

      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
    };
  };
}
