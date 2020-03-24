from postgres:12.2-alpine
USER root
# RUN rm -rf /var/cache/apk/* && \
#    rm -rf /tmp/*
run apk --update add --no-cache gcc make libc-dev clang llvm
#copy dnsrr-2.1.9-62.tgz /home/pgbuild/dnsrr-2.1.9-62.tgz
#run (mkdir -p /home/pgbuild; cd /home/pgbuild; tar xfvz dnsrr-2.1.9-62.tgz)
#run sed -i 's/sys_errlist\[errno\]/"err"/g' /home/pgbuild/dnsrr-2.1.9-62/dnsrr.c
#run (cd /home/pgbuild/dnsrr-2.1.9-62; PATH={$PGBIN}:$PATH USE_PGXS=1 make clean install)
