{ stdenv
, lib
, fetchurl
, pkg-config
, glib
, gtk4
, libgee
, gettext
, vala
, gnome
, libintl
, meson
, ninja
}:

stdenv.mkDerivation rec {
  pname = "libgnome-games-support";
  version = "2.0.beta.2";

  src = fetchurl {
    url = "mirror://gnome/sources/${pname}/${lib.versions.majorMinor version}/${pname}-${version}.tar.xz";
    sha256 = "jB7lF4q8wppOgUJnuMXvo6DvmwkxbAAgCQ4Ex6OYxNw=";
  };

  nativeBuildInputs = [
    gettext
    meson
    ninja
    pkg-config
    vala
  ];

  buildInputs = [
    libintl
  ];

  propagatedBuildInputs = [
    # Required by libgnome-games-support-2.pc
    glib
    gtk4
    libgee
  ];

  passthru = {
    updateScript = gnome.updateScript {
      packageName = pname;
      attrPath = "gnome.${pname}";
      versionPolicy = "odd-unstable";
    };
  };

  meta = with lib; {
    description = "Small library intended for internal use by GNOME Games, but it may be used by others";
    homepage = "https://wiki.gnome.org/Apps/Games";
    license = licenses.lgpl3Plus;
    maintainers = teams.gnome.members;
    platforms = platforms.unix;
  };
}
