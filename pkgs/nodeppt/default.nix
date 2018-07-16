{ yarn2nix, fetchFromGitHub }:
yarn2nix.mkYarnPackage {
  name = "nodeppt";
  src = fetchFromGitHub {
    owner = "ksky521";
    repo = "nodeppt";
    rev = "5c6475554297f5cd2f0fb7521a15ba927f90f9bb";
    sha256 = "0ydwgy8w9d785bcc22a298hzwf4qa9sm9d0a40v037cmr2qqsh1v";
  };
  extraBuildInputs = [ ];
  packageJson = ./package.json;
  yarnLock = ./yarn.lock;
}
