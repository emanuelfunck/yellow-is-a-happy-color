#!/bin/sh
# Baut aus index.html (der Quelle, die als Claude-Artifact veroeffentlicht
# wird) die eigenstaendige Seite docs/index.html fuer GitHub Pages.
#
# Hintergrund: Claude-Artifacts betten die Datei beim Veroeffentlichen in ein
# HTML-Grundgeruest ein, deshalb enthaelt die Quelle kein <!doctype>, <html>,
# <head> oder <body>. Auf GitHub Pages fehlt dieses Geruest, also setzt dieses
# Skript es davor. Inhalt und Gestaltung sind in beiden Faellen identisch.
#
# Aufruf:  ./build.sh      danach committen und pushen.

set -e
cd "$(dirname "$0")"
mkdir -p docs

{
  cat <<'HEAD'
<!doctype html>
<html lang="de">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>Yellow Is a Happy Color</title>
<style>
  :root {
    color-scheme: light;
    padding-top: env(safe-area-inset-top, 0px);
    padding-bottom: env(safe-area-inset-bottom, 0px);
  }
  body { margin: 0; font: 14px system-ui, sans-serif; }
  img { max-width: 100%; }
  [hidden] { display: none !important; }
</style>
</head>
<body>
HEAD
  cat index.html
  cat <<'FOOT'
</body>
</html>
FOOT
} > docs/index.html

echo "docs/index.html gebaut aus index.html"
