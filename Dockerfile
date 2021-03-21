FROM alpine:edge

ARG USER=tyler
ARG EMAIL="tgannon@gmail.com"
ARG NAME="Tyler Gannon"

RUN apk add --no-cache \
        bash \
        git \
        lazygit \
        nodejs \
        npm \
        sudo \
        vim \
        zsh \
    && wget https://pnpm.js.org/pnpm.js \
    && node ./pnpm.js add --global pnpm \
    && rm -rf pnpm.js \
    && pnpm i -g \
        eslint \
        nodemon \
        npx \
        pure-prompt \
        ts-node \
        typescript \
    && apk del npm \
    && addgroup -g 1000 -S ${USER} \
    && adduser -h /home/${USER} -s /bin/zsh -D -u 1000 -G ${USER} -S ${USER} \
    && mkdir -p /code/node_modules /home/${USER}/.vscode-server /home/${USER}/.histfile \
    && chown -R 1000:1000 /home/${USER} /code \
    && echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER} \
    && git clone https://github.com/CaffeineViking/vimrc.git .vim_temp \
    && cd .vim_temp && sudo -u ${USER} ./setup.sh && cd .. \
    && rm -rf .vim_temp

COPY --chown=${USER}:${USER} ./profile/.zshrc /home/${USER}/.zshrc
USER ${USER}

ENV EDITOR=vim \
    PATH=/code/script:${PATH}:/code/node_modules/.bin

WORKDIR /code
VOLUME [ "/code", "/code/node_modules" ]
CMD [ "zsh" ]
