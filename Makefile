.POSIX:

PREFIX = /usr/local

all:

install:
	install -Dm755 luametatex mtxrun -t $(DESTDIR)$(PREFIX)/bin
	ln -sf ../share/context/texmf/scripts/context/lua/mtxrun.lua $(DESTDIR)$(PREFIX)/bin/
	mkdir -p $(DESTDIR)$(PREFIX)/share/context
	cp -rf texmf $(DESTDIR)$(PREFIX)/share/context/
