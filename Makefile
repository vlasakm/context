.POSIX:

PREFIX = /usr/local

all:

install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	mkdir -p $(DESTDIR)$(PREFIX)/share/context
	cp -f luametatex mtxrun $(DESTDIR)$(PREFIX)/bin/
	chmod +x $(DESTDIR)$(PREFIX)/bin/luametatex $(DESTDIR)$(PREFIX)/bin/mtxrun
	ln -sf ../share/context/texmf/scripts/context/lua/mtxrun.lua $(DESTDIR)$(PREFIX)/bin/
	cp -rf texmf $(DESTDIR)$(PREFIX)/share/context/
