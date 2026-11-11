# Dev workspace image for llm-agent.
# Python toolbox only; application code is bind-mounted at /workspace.
FROM python:3.12-slim-bookworm

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    UV_LINK_MODE=copy

# System packages: build toolchain + common CLI tools.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
        git \
        htop \
        jq \
        netcat-openbsd \
        procps \
        screen \
        sudo \
        vim \
    && rm -rf /var/lib/apt/lists/*

# Non-root user matching the host UID/GID (keeps the bind-mounted repo writable).
RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m -s /bin/bash ${USERNAME} \
    && echo "${USERNAME} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}

# Terminal: custom bash prompt + git coloring for the dev user.
COPY --chown=${USERNAME}:${USERNAME} bashrc_extra.sh /home/${USERNAME}/.bashrc_extra
RUN echo "[ -f /home/${USERNAME}/.bashrc_extra ] && . /home/${USERNAME}/.bashrc_extra" >> /home/${USERNAME}/.bashrc

# uv — fast Python package/project manager.
RUN pip install --no-cache-dir uv

WORKDIR /workspace

USER ${USERNAME}

# Keep the container alive; VS Code attaches and services are started manually.
CMD ["sleep", "infinity"]
