VERSION := $(shell grep Version: pgcmp.spec | cut -d : -f 2 | sed 's/ //g'| fmt)
VDIR := pgcmp-$(VERSION)
TARBALL := pgcmp-$(VERSION).tar.bz2

all: rpm

$(TARBALL): README.html README.txt pgcmp pgcmp-dump pgcmp.spec
	mkdir -p $(VDIR)
	cp README.html README.txt pgcmp pgcmp-dump pgcmp.spec $(VDIR)
	tar cfvj $(TARBALL) $(VDIR)

rpm: $(TARBALL)
	rpmbuild -tb $(TARBALL)

README.html: org-to-html README.org
	ruby org-to-html

clean:
	rm -rf $(VDIR)
	rm -f $(TARBALL)
