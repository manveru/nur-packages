{ pkgs }: let inherit (pkgs) callPackage; in {
  scylla = callPackage ./pkgs/scylla {};
  # p5-manager = callPackage ./pkgs/p5-manager {};
  cht-sh = callPackage ./pkgs/cht-sh {};
  markpress = callPackage ./pkgs/markpress {};
  diakonos = callPackage ./pkgs/diakonos {};
  lib = {
    git-info = callPackage ./lib/git-info {};
  };
  modules = {
    scylla = callPackage ./modules/scylla.nix {};
  };
}
