{ yarn2nix }:
yarn2nix.mkYarnPackage {
  name = "nodeppt";
  src = fetchGit {
    url = "https://github.com/ksky521/nodeppt";
    rev = "5c6475554297f5cd2f0fb7521a15ba927f90f9bb";
  };
  extraBuildInputs = [ ];
  packageJson = ./package.json;
  yarnLock = ./yarn.lock;
}
