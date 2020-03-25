FROM node:13-slim

ENV NODE_ENV TEST

WORKDIR /usr/src/app

COPY package*.json ./

RUN apt-get update && apt-get install -f -y netcat \ 
    && npm install --only=dev
    #&& rm -rf /var/lib/apt/lists/*
    
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod 777 /usr/local/bin/docker-entrypoint.sh && \
    ln -s usr/local/bin/docker-entrypoint.sh / # backwards compat

ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 1337
CMD ["npm", "run", "test"]
