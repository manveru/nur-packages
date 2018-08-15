{ ruby, buildRubyGem }:
let
thor = buildRubyGem {
  inherit ruby;
  gemName = "thor";
  type = "gem";
  version = "0.18.1";
  source.sha256 = "0d1g37j6sc7fkidf8rqlm3wh9zgyg3g7y8h2x1y34hmil5ywa8c3";
};
in
buildRubyGem {
  inherit ruby;
  gemName = "redzone";
  type = "gem";
  version = "0.0.3";
  source.sha256 = "1x1k3ligilnlc0r0i1v3xznck69l7azz058la2jzxr6vsl1rdzba";
  gemPath = [ thor ];
}
