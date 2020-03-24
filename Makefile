VERSION := $(shell grep Version: pgcmp.spec | cut -d : -f 2 | sed 's/ //g'| fmt)
PVERSION := pgcmp-$(VERSION)
VDIR := $(ARTIFACT_TARGET)/$(PVERSION)
TARBALL := $(ARTIFACT_TARGET)/$(PVERSION).tar.bz2

.PHONY: docker

ifndef ARTIFACT_TARGET
$(error ARTIFACT_TARGET is not set - this is the directory in which to deploy output artifacts)
endif

all: $(TARBALL)

$(TARBALL): README.html README.org pgcmp pgcmp-dump pgcmp.spec
	mkdir -p $(VDIR)
	cp README.html README.org pgcmp pgcmp-dump pgcmp.spec $(VDIR)
	(cd $(ARTIFACT_TARGET) ; tar cfvj $(TARBALL) $(PVERSION) )

README.html: org-to-html README.org
	ruby org-to-html

docker: docker/Dockerfile
	docker build --network=host docker -t pg_alpine_rr:latest

clean:
	rm -rf $(VDIR)
	rm -f $(TARBALL)
