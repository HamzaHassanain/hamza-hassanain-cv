# Hamza Mohammed Hassanain — CV

LaTeX source for my résumé. **[📄 Download the compiled PDF](./Hamza_Mohammed_Hassanain_CV.pdf)**

Cloud & Full-Stack Engineer · AWS Certified Solutions Architect – Associate · 2× ACPC Finalist.

## Build

One command builds the source and updates the committed PDF, enforcing the 1-page rule:

```bash
sh ./build.sh            # -> Hamza_Mohammed_Hassanain_CV.pdf  (fails if not exactly 1 page)
```

`build.sh` uses `tectonic` if it's on your `PATH`, otherwise it bootstraps a local copy into
`./.tools/` (git-ignored). `pdflatex` is used as a fallback if present.

### Auto-build before every commit

A pre-commit hook rebuilds the PDF and stages it whenever you change any `.tex`/`.sty`, so the
committed PDF is never stale. Enable it once per clone:

```bash
git config core.hooksPath .githooks
```

If the CV ever compiles to more than one page, the hook aborts the commit.

### CI

[`.github/workflows/build-cv.yml`](.github/workflows/build-cv.yml) builds the CV on every push,
fails the run if it is not exactly one page, and uploads the PDF as a downloadable artifact.

## Layout

```
resume.tex          main file — contact macros, section order
_header.tex         first-page header (contact + links)
TLCresume.sty       styling (fonts, spacing, section rules)
sections/           one file per section
  education.tex     degree + AWS certification
  experience.tex    Repovive — Backend & Infrastructure Engineer
  open-source.tex   merged contributions: GitLab, LLVM/Clang, Swift NIO
  projects.tex      AWS reference architecture, SigmaLoop, Polyman, C++ systems
  blogs.tex         technical writing
  achivements.tex   ICPC ECPC / ACPC
  skills.tex        cloud, backend, languages
```

## House rules (keep these when editing)

These constraints keep the CV tight and credible — preserve them in any future edit:

1. **One page.** Everything must fit on a single letter page. Verify page count after every change.
2. **Small but readable fonts.** Base is `10pt` (`sourcesanspro`). Maximise information density, but never below readable size.
3. **No wasted horizontal space.** Write each line to run close to the full text width — no short, half-empty lines.
4. **Each bullet is at most one line.** If a bullet wraps, shorten it (drop a link or a few words), don't let it spill.
5. **Header on the first page only.** Page 1 uses `\thispagestyle{fancy}`; later pages use the `noheader` style.
6. **Every claim must survive a click.** Describe merged PRs/MRs by what the diff actually does; link them. No inflated framing.

## License

See [`LICENSE.txt`](./LICENSE.txt). Résumé content © Hamza Mohammed Hassanain; template by Timmy Chan (TLCresume).
