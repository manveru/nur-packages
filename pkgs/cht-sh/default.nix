{ stdenv, fetchurl }:
stdenv.mkDerivation {
  name = "cht-sh";
  src = fetchurl {
    url = https://raw.githubusercontent.com/chubin/cheat.sh/453753497e63ddd92f0b27316568f86322e73e9a/share/cht.sh.txt;
    sha256 = "1wzrcn17imyy98r6h4nd9j3fi61dlzp92p4iyqqfl6ijnn4jpm6q";
  };
  phases = "installPhase";
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/cht.sh
    chmod +x $out/bin/cht.sh
  '';
}
