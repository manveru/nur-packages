{ callPackage }: {
  scylla = callPackage ./pkgs/scylla {};
  # p5-manager = callPackage ./pkgs/p5-manager {};
  cht-sh = callPackage ./pkgs/cht-sh {};
  markpress = callPackage ./pkgs/markpress {};
  nodeppt = callPackage ./pkgs/nodeppt {};
  lib = {
    git-info = callPackage ./lib/git-info {};
  };
}
