{ stdenv, fetchFromGitHub
, ruby, makeWrapper, buildRubyGem, ncurses }:
let
  curses = buildRubyGem {
    name = "curses";
    gemName = "curses";
    version = "1.2.4";
    source.sha256 = "0hdgz18a21wi2hg5aw8abc012ni055jr1fbam0v2r8nsqsnx8dy2";
		buildInputs = [ ncurses ];
		type = "gem";
		ruby = ruby;
  };
in
stdenv.mkDerivation {
  name = "diakonos";
  src = fetchFromGitHub {
    owner = "Pistos";
    repo = "diakonos";
    rev = "caf9b48bc0f7c6d270dcfbc1be864678390bd021";
    sha256 = "0qkd86222rxqgjx75h8bqs9wfigsc9fy8g4690ypqcsd4mnf6nic";
  };

  buildInputs = [ ruby makeWrapper ];

  installPhase = ''
    mkdir -p $out
    ruby install.rb --verbose \
      --prefix $out \
      --conf-dir $out/etc
    ln -s ${curses}/${ruby.gemPath}/gems/curses-${curses.version} \
          $out/lib/ruby/site_ruby/${ruby.version.libDir}/curses
    wrapProgram $out/bin/diakonos \
      --set RUBYLIB "$out/lib/ruby/site_ruby/${ruby.version.libDir}:$out/lib/ruby/site_ruby/${ruby.version.libDir}/curses/lib"
  '';
}
