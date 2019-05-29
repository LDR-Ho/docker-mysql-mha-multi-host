FROM mysql:5.7.17

COPY ./build /build
RUN build_deps='ssh sshpass perl libdbi-perl libdbd-mysql-perl make' \
    && pack='/build' \
    && mv /etc/apt/sources.list /etc/apt/sources.list.bak \
    && mv $pack/sources-163.list /etc/apt/sources.list \
    && apt-get clean \
    && apt-get update \
    && apt-get -y --force-yes install $build_deps \
    && apt-get purge -y --auto-remove $buil_deps \
    && sed -n -i 's/UsePAM yes/UsePAM no/gp' /etc/ssh/sshd_config \
    && tar -zxf $pack/mha4mysql-node-0.58.tar.gz -C /opt \
    && cd /opt/mha4mysql-node-0.58 \
    && perl Makefile.PL \
    && make \
    && make install \
    && rm -rf /opt/mha4mysql*