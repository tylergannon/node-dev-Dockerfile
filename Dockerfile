FROM tylergannon/node:latest

ARG USER=tyler
ARG EMAIL="tgannon@gmail.com"
ARG NAME="Tyler Gannon"

RUN apk add --no-cache \
        bash \
        curl \
        git \
        lazygit \
        p7zip \
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
    && addgroup -g 1000 -S ${USER} \
    && adduser -h /home/${USER} -s /bin/zsh -D -u 1000 -G ${USER} -S ${USER} \
    && mkdir -p /code/node_modules /home/${USER}/.vscode-server /home/${USER}/.histfile \
    && chown -R 1000:1000 /home/${USER} /code \
    && echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER} \
    && git clone https://github.com/CaffeineViking/vimrc.git .vim_temp \
    && cd .vim_temp && sudo -u ${USER} ./setup.sh && cd .. \
    && rm -rf .vim_temp

ARG rebuild=now3
RUN mkdir -p /etc/init_server.d && chmod -R o+rwx /etc/init_server.d
COPY --chown=${USER}:${USER} ./profile/.zshrc /home/${USER}/.zshrc
COPY ./script/init_server ./script/waitfor /usr/bin/
COPY --chown=${USER}:${USER} ./script/install_packages.sh /etc/init_server.d/
USER ${USER}
# RUN curl https://pyenv.run | bash

ENV EDITOR=vim \
    PATH=/code/script:${PATH}:/code/node_modules/.bin:${HOME}/.pyenv/bin

WORKDIR /code
VOLUME [ "/code", "/code/node_modules" ]
CMD [ "zsh" ]
ENTRYPOINT [ "/usr/bin/init_server" ]
