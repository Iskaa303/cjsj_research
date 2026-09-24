{ pkgs, ... }:

let
  maquette-src = pkgs.fetchFromGitHub {
    owner = "bernsteining";
    repo = "maquette";
    rev = "fdb31b1a3f5e667fcd51b87a323051e647bfe55a";
    hash = "sha256-muqOsKB9T9FlNtTrF0xjwt8UVwvaMx8vhNGhRJbKGPY=";
  };

  typstPkgs = with pkgs.typstPackages; [ cetz oxifmt ];

  customTypstPackages = pkgs.runCommand "typst-packages" { } ''
    root=$out/share/typst/packages/preview

    copyPkg() {
      mkdir -p "$root/$1/$2"
      cp -rT "$3" "$root/$1/$2"
    }

    copyPkg maquette 0.2.0 ${maquette-src}/crates/maquette/maquette
    copyPkg maquette-gltf 0.1.0 ${maquette-src}/crates/maquette-gltf/maquette-gltf

    ${pkgs.lib.concatMapStrings (p:
      "copyPkg ${p.pname} ${p.version} ${p}/lib/typst-packages/${p.pname}/${p.version}\n"
    ) typstPkgs}
  '';
in
{
  packages = [ pkgs.typst ];

  env = {
    TYPST_PACKAGE_PATH = "${customTypstPackages}/share/typst/packages";
  };
}
