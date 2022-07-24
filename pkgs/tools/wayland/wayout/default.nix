{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "wayout";
  version = "1.1.2";

  src = fetchFromGitHub {
    owner = "waycrate";
    repo = pname;
    rev = version;
    sha256 = "oNZhvIulzwU6gY0Au1Q/OJqaJ/eM9fKsUOU1Ba7udaM=";
  };

  cargoSha256 = "sha256-T/iuY9HPlRAr45mC7A1pCjk9DSZ/ptwAr+3+AtShrSI=";

  meta = with lib; {
    description = "Simple tool to set output modes for wlroots compositors";
    homepage = "https://git.sr.ht/~shinyzenith/wayout";
    license = licenses.bsd2;
    maintainers = [ maintainers.stehessel ];
  };
}
