FROM alpine:3.5
RUN apk add --update curl jq mysql-client

ADD run.sh /run.sh

CMD /bin/sh /run.sh
