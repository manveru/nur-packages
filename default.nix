{ callPackage }: {
  scylla = callPackage ./pkgs/scylla {};
  p5-manager = callPackage ./pkgs/p5-manager {};
  cht-sh = callPackage ./pkgs/cht-sh {};
}
