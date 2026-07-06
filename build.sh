#!/usr/bin/env sh
# Build the CV from LaTeX source and update Hamza_Mohammed_Hassanain_CV.pdf.
# Enforces the house rule: the CV must be exactly ONE page.
# Usage: sh ./build.sh
set -eu
cd "$(dirname "$0")"

OUT="Hamza_Mohammed_Hassanain_CV.pdf"

# --- locate (or bootstrap) a LaTeX engine ---------------------------------
TEX=""
if command -v tectonic >/dev/null 2>&1; then TEX="tectonic"
elif [ -x ./.tools/tectonic ]; then TEX="./.tools/tectonic"
elif command -v pdflatex >/dev/null 2>&1; then TEX="pdflatex"
fi

if [ -z "$TEX" ]; then
  echo "No LaTeX engine found — bootstrapping tectonic into ./.tools ..."
  mkdir -p .tools
  ( cd .tools && curl --proto '=https' --tlsv1.2 -fsSL https://drop-sh.fullyjustified.net | sh )
  TEX="./.tools/tectonic"
fi

# --- compile --------------------------------------------------------------
mkdir -p build
case "$TEX" in
  *tectonic)
    "$TEX" -X compile resume.tex --outdir build >/dev/null ;;
  *pdflatex)
    pdflatex -output-directory build -interaction=nonstopmode resume.tex >/dev/null
    pdflatex -output-directory build -interaction=nonstopmode resume.tex >/dev/null ;;
esac

# --- enforce single page --------------------------------------------------
if command -v pdfinfo >/dev/null 2>&1; then
  PAGES=$(pdfinfo build/resume.pdf | awk '/^Pages/{print $2}')
  if [ "$PAGES" != "1" ]; then
    echo "ERROR: CV compiled to $PAGES pages — it must be exactly 1. $OUT NOT updated." >&2
    exit 1
  fi
  echo "Page count OK (1)."
else
  echo "WARNING: pdfinfo not found; skipping the 1-page check." >&2
fi

cp build/resume.pdf "$OUT"
echo "Built and updated $OUT"
