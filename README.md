# Packagable ConTeXt LMTX for Linux distributions

Proof of concept x86-64 Linux only. The `texmf` directory is substantially thinned version of [`texmf-context`](http://lmtx.pragma-ade.nl/install-lmtx/texmf-context.zip) (no docs, no fonts, etc.), also the usual `texmf-fonts` and `texmf` are missing! Prerelease version of [`luametatex`](https://dl.contextgarden.net/build/luametatex/x86_64-linux/) is used.

For real ConTeXt and installation instructions see [the ConTeXt Garden](https://wiki.contextgarden.net/Main_Page).

## Installation instructions

Use `make install`, but set `DESTDIR` and `PREFIX` as you please.

E.g. to create a Linux package you would do something like:

```
make DESTDIR="$pkgdir" PREFIX=/usr install
```

To install locally to `/usr/local` you would run:

```
make PREFIX=/usr/local install
```

To create a "portable" (movable) directory called `context` you can run:

```
make DESTDIR=context PREFIX= install
```

## Running

Run the installed `mtxrun` binary with proper arguments. E.g. to run ConTeXt do:

```
path/to/mtxrun --script context myfile.tex
```

## Configuration

Main things to configure are the directories from which ConTeXt loads files. There are two
kinds of these directories:

 - "flat" are not recursively searched directories and are applicable to all
   file types
 - "tree" adhere to the [TDS standard](https://tug.org/tds/), the search is
   recursive, but filetypes have their own prescribed subtrees (e.g. `.tex`
   files go into `/tex` and `.bib` files to `/bibtex`)

Flat directories are read from the `TEXMFDOTDIR` variable (by default `.`, i.e.
the current directory). But in general it is a semicolon (`;`) separated list
of directories (like `PATH`, but with `;`).

Similarly list of TDS trees ("texmf" directories) is read from the `TEXMF`
variable. By default it points only to the `texmf` directory distributed by
this package, which is available as `TEXMFCONTEXT`.

The variables can be set either in the environment, or in the `texmfcnf.lua`
configuration files. The default configuration file is next to the installed
`texmf` directory. If you want to change the defaults, copy the configuration
file `texmfcnf.lua` file to either `~/.config/context/` (for user
configuration) or to `/etc/context/` (for system configuration). Then you make
changes there. Only one file takes effect (user config file is preferred to the
system one).

Other interesting variables to configure are:

 - `TEXMFCACHE = "$HOME/.cache"` , ConTeXt stores cached files in
   `$TEXMFCACHE/luametatex-cache`
 - `OSFONTDIR = "/usr/share/fonts//"`, the directory with "operating system
   fonts" (`//` at the end means search all subdirectories recursively)

If you have say a flat directory with your macros (`$HOME/mymacros`), a TeX
Live TDS tree (`/usr/share/texlive/2022/texmf-dist`, preferably without ConTeXt
to prevent clashes) which you want to use as fallback (e.g. for fonts) and
other fonts installed locally under `$HOME/.local/share/fonts` you can do:

```
# first search in the current directory, then in `mymacros`
export TEXMFDOTDIR='.;$HOME/mymacros'

# then continue to look into the ConTeXt TDS texmf tree, falling back to the TeX Live one
export TEXMF='$TEXMFCONTEXT;/usr/share/texlive/2022/texmf-dist'

# on top of that if searching for OTF and TTF files, search also local fonts and system fonts
export OSFONTDIR='$HOME/.local/share/fonts//;/usr/share/fonts//'
```

Or without modifying the shell environment and just changing the variables for this ConTeXt run:

```
TEXMFDOTDIR='.;$HOME/mymacros' TEXMF='$TEXMFCONTEXT;/usr/share/texlive/2022/texmf-dist' OSFONTDIR='$HOME/.local/share/fonts//;/usr/share/fonts//' path/to/mtxrun --script context myfile.tex
```

Or the equivalent in the configuration file.


Notice the use of single quotes to prevent expansion in the shell! You want
ConTeXt to do the variable expansion (variables from the environment take
priority over the ones from configuration files).
