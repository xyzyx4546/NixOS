{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "layan-border-cursors";
  version = "1.0";

  src = ./layan.zip;

  unpackPhase = ''
    runHook preUnpack
    ${pkgs.unzip}/bin/unzip $src
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    install -Dm644 static/* -t $out/share/icons/default
    runHook postInstall
  '';
}