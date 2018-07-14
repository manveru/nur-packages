{ yarn2nix, fetchFromGitHub }:
yarn2nix.mkYarnPackage {
  name = "p5-manager";
  src = fetchFromGitHub {
    owner = "chiunhau";
    repo = "p5-manager";
    rev = "950260d63f3667c948b6781d962ba1a91b380999";
    sha256 = "12j174dqg0xz8ch7zkw3ccp8c4wapnmh7f77zlrw0rq8nxiinir4";
  };
  packageJson = ./package.json;
  yarnLock = ./yarn.lock;
  yarnNix = ./yarn.nix;
}
