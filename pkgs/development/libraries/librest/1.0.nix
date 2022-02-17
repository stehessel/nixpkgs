{ lib
, stdenv
, fetchurl
, meson
, ninja
, pkg-config
, gi-docgen
, glib
, json-glib
, libsoup
, gobject-introspection
, gnome
}:

stdenv.mkDerivation rec {
  pname = "rest";
  version = "0.9.0";

  outputs = [ "out" "dev" "devdoc" ];

  src = fetchurl {
    url = "mirror://gnome/sources/${pname}/${lib.versions.majorMinor version}/${pname}-${version}.tar.xz";
    sha256 = "hbK8k0ESgTlTm1PuU/BTMxC8ljkv1kWGOgQEELgevmY=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    gi-docgen
    gobject-introspection
  ];

  buildInputs = [
    glib
    json-glib
    libsoup
  ];

  mesonFlags = [
    "-Dexamples=false"

    # Remove when https://gitlab.gnome.org/GNOME/librest/merge_requests/2 is merged.
    "-Dca_certificates=true"
    "-Dca_certificates_path=/etc/ssl/certs/ca-certificates.crt"
  ];

  postPatch = ''
    # https://gitlab.gnome.org/GNOME/librest/-/merge_requests/19
    substituteInPlace meson.build \
      --replace "con." "conf."
  '';

  postFixup = ''
    # Cannot be in postInstall, otherwise _multioutDocs hook in preFixup will move right back.
    moveToOutput "share/doc" "$devdoc"
  '';

  passthru = {
    updateScript = gnome.updateScript {
      packageName = pname;
      attrPath = "librest";
      versionPolicy = "odd-unstable";
    };
  };

  meta = with lib; {
    description = "Helper library for RESTful services";
    homepage = "https://wiki.gnome.org/Projects/Librest";
    license = licenses.lgpl21Only;
    platforms = platforms.unix;
    maintainers = teams.gnome.members;
  };
}
