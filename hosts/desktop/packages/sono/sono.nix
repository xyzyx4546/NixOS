{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "berkeley-mono-typeface";
  version = "1.009";

  src = ./Sono.zip;

  unpackPhase = ''
    runHook preUnpack
    ${pkgs.unzip}/bin/unzip $src

    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    install -Dm644 static/*.ttf -t $out/share/fonts/truetype

    runHook postInstall
  '';
}