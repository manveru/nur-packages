{ yarn2nix, oniguruma, fetchFromGitHub }:
yarn2nix.mkYarnPackage {
  name = "markpress";
  src = fetchFromGitHub {
    owner = "gamell";
    repo = "markpress";
    rev = "v4.0.0";
    sha256 = "1xhdmdmw5addp8q0w397jyvd2zpmr8g0fpvh83rlia4212nsiqa8";
  };
  extraBuildInputs = [ oniguruma ];
  packageJson = ./package.json;
  yarnLock = ./yarn.lock;
  yarnNix = ./yarn.nix;
}
