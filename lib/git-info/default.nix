{ stdenv, lib, git }:
with builtins;
cmd: repo:
  lib.removeSuffix "\n" (readFile (
    stdenv.mkDerivation rec {
      name = "git-info";
      src = lib.sourceByRegex repo ["\.git.*"];
      passAsFile = ["buildCommand"];
      buildInputs = [git];
      buildCommand = ''
        cd $src
        ${cmd} > $out
      '';
    }))
