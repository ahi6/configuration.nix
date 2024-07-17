final: prev: let
  light = ./wallhaven-m9wyyy.png;
  dark = ./wallhaven-1kqv13.png;
  background-name = "NightInTheWoods";
  background-xml = ''
    <?xml version="1.0"?>
    <!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
    <wallpapers>
      <wallpaper deleted="false">
        <name>${background-name}</name>
        <filename>${light}</filename>
        <filename-dark>${dark}</filename-dark>
        <options>zoom</options>
        <shade_type>solid</shade_type>
        <pcolor>#241f31</pcolor>
        <scolor>#000000</scolor>
      </wallpaper>
    </wallpapers>
  '';
in {
  gnome = prev.gnome.overrideScope (gfinal: gprev: {
    gnome-backgrounds = gprev.gnome-backgrounds.overrideAttrs (oldAttrs: {
      postInstall =
        (oldAttrs.postInstall or "")
        + ''
          cat <<EOF > $out/share/gnome-background-properties/${background-name}.xml
          ${background-xml}
          EOF
        ''; # we do a little heredoc syntax
    });
  });
}
