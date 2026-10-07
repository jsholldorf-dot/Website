#!/bin/sh
# Baut index.html aus dem Seitenfragment in src/ (das Fragment wird auch als Artifact veröffentlicht)
set -e
{
  printf '<!doctype html>\n<html lang="de">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n</head>\n<body>\n'
  cat src/motion-lab.html
  printf '\n</body>\n</html>\n'
} > index.html
