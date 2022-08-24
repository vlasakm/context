.POSIX:

PREFIX = /usr/local

all:

install:
	install -Dm755 luametatex mtxrun -t $(DESTDIR)$(PREFIX)/bin
	ln -sf mtxrun $(DESTDIR)$(PREFIX)/bin/context
	ln -sf ../share/context/texmf/scripts/context/lua/mtxrun.lua $(DESTDIR)$(PREFIX)/bin/
	ln -sf ../share/context/texmf/scripts/context/lua/context.lua $(DESTDIR)$(PREFIX)/bin/
	mkdir -p $(DESTDIR)$(PREFIX)/share/context
	cp -rf texmf $(DESTDIR)$(PREFIX)/share/context/
	# set files 644 and directories 755
	chmod -R a=r,u+w,a+X $(DESTDIR)$(PREFIX)/share/context/
