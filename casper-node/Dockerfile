FROM ubuntu:latest

RUN apt update -y  && apt install -y wget coreutils
RUN apt-get update && apt-get upgrade -y  && \
			apt-get -y install cmake && \
			apt-get -y install curl && \
 			apt-get -y install apt-utils && \
			apt-get -y install wget coreutils
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
RUN echo 'source $HOME/.cargo/env' >> $HOME/.bashrc
RUN apt-get install -y libssl-dev  \
			pkg-config \
			build-essential  \
			git  \
			jq

RUN curl -JLO https://bintray.com/casperlabs/debian/download_file?file_path=casper-node-launcher_0.2.0-0_amd64.deb
RUN curl -JLO https://bintray.com/casperlabs/debian/download_file?file_path=casper-client_0.7.6-0_amd64.deb
RUN apt-get install -y ./casper-client_0.7.6-0_amd64.deb ./casper-node-launcher_0.2.0-0_amd64.deb
RUN casper-client keygen /etc/casper/validator_keys/

VOLUME /etc/casper/validator_keys
RUN rm /etc/casper/1_0_0/config.toml

VOLUME /etc/casper/1_0_0/config.toml
VOLUME /etc/casper/1_0_0/chainspec.toml
VOLUME /etc/casper/1_0_0/accounts.csv

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["validator" "/etc/casper/1_0_0/config.toml"]
