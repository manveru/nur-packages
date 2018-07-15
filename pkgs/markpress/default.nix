{ yarn2nix, oniguruma }:
yarn2nix.mkYarnPackage {
  name = "markpress";
  src = fetchGit {
    url = "https://github.com/gamell/markpress";
    rev = "33ac784c191f9b86b1cf65b94ccc9c01f75e7a7b";
    ref = "v4.0.0";
  };
  extraBuildInputs = [ oniguruma ];
  packageJson = ./package.json;
  yarnLock = ./yarn.lock;
  yarnNix = ./yarn.nix;
}
