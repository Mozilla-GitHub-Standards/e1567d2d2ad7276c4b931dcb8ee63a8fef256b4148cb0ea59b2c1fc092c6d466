# Mozilla Kinto Load-Tester
FROM stackbrew/debian:sid

MAINTAINER Remy HUBSCHER

RUN \
    apt-get update; \
    apt-get install -y python3-pip python3-venv git build-essential make; \
    apt-get install -y python3-dev libssl-dev libffi-dev; \
    git clone https://github.com/mozilla-services/ailoads-kinto /home/kinto; \
    cd /home/kinto; \
    make build; \
	apt-get remove -y -qq git build-essential make python3-pip python3-virtualenv libssl-dev libffi-dev; \
    apt-get autoremove -y -qq; \
    apt-get clean -y 

WORKDIR /home/kinto

# run the test
CMD venv/bin/ailoads -v -d $KINTO_DURATION -u $KINTO_NB_USERS
