{ lib, stdenv, fetchFromGitHub, openssl, sqlite }:

stdenv.mkDerivation rec {
  pname = "signalbackup-tools";
  version = "20220526";

  src = fetchFromGitHub {
    owner = "bepaald";
    repo = pname;
    rev = version;
    sha256 = "sha256-vFq9NvQboqGVzwiH2KPhT6jsdY5i2oKIgEaZKfBsb/o=";
  };

  buildInputs = [ openssl sqlite ];
  buildFlags = [
    "-Wall"
    "-Wextra"
    "-Wshadow"
    "-Wold-style-cast"
    "-Woverloaded-virtual"
    "-pedantic"
    "-std=c++2a"
    "-O3"
    "-march=native"
  ];
  buildPhase = ''
    $CXX $buildFlags */*.cc *.cc -lcrypto -lsqlite3 -o signalbackup-tools
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp signalbackup-tools $out/bin/
  '';

  meta = with lib; {
    description = "Tool to work with Signal Backup files";
    homepage = "https://github.com/bepaald/signalbackup-tools";
    license = licenses.gpl3Only;
    maintainers = [ maintainers.malo ];
    platforms = platforms.all;
  };
}
