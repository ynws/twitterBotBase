FROM ubuntu

MAINTAINER ynws

ENV APP_ROOT /home
WORKDIR $APP_ROOT

RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN apt-get update && \
    apt-get install ruby \
                    ruby-dev \
                    make \
                    gcc \
                    g++ \
                    -y && \
    rm -rf /var/lib/apt/lists/*

RUN gem install twitter

COPY streaming.rb $APP_ROOT/

CMD ["ruby", "streaming.rb"]
