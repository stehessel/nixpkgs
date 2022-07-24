{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "swhkd";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "waycrate";
    repo = pname;
    rev = version;
    sha256 = "drSZ4u+yOPn1Sbf0ug5hmNDRrYGrhq40Q48DE5CiGrI=";
  };

  cargoSha256 = "sha256-1/ApCCS89eMcy6Yi+W8YCqHdCzo3NWcwBujmqpAuF5k=";

  meta = with lib; {
    description = "Sxhkd clone for Wayland (works on TTY and X11 too)";
    homepage = "https://github.com/waycrate/swhkd";
    license = licenses.bsd2;
    maintainers = [ maintainers.stehessel ];
    platforms = platforms.linux;
  };
}
