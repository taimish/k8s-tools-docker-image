# docker build -t k8s-tools:latest .

FROM alpine:latest

# Creating new user and group "k8stools" with UID and GID 111, sh as default shell
RUN \
	addgroup -g 111 -S k8stools; \
	adduser -u 111 -D -G k8stools -H -h /home/k8stools -s /bin/sh k8stools; \
	mkdir -p /home/k8stools; \
	chown -R k8stools:k8stools /home/k8stools;

# Installing support tools using apk
RUN \
  apk add curl git
  
# Installing k8s tools
RUN \
  cd /tmp; \
  K8S_VER=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt) && \
  curl -LO https://storage.googleapis.com/kubernetes-release/release/${K8S_VER}/bin/linux/amd64/kubectl && \
  chmod 775 kubectl && \
  mv /tmp/kubectl /bin/kubectl && \
  curl -s https://api.github.com/repos/kubernetes-sigs/kustomize/releases | grep browser_download_url | grep linux | head -n1 | awk '-F"' '{print $4}' | xargs curl -LO && \
  tar xvzf kustomize*.tar.gz && \
  chmod 775 kustomize && \
  mv /tmp/kustomize /bin/kustomize && \
  curl -s https://api.github.com/repos/zegl/kube-score/releases | grep browser_download_url | grep tar | grep linux | head -n1 | awk '-F"' '{print $4}' | xargs curl -LO && \
  tar xvzf kube-score*.tar.gz && \
  chmod 775 kube-score && \
  mv /tmp/kube-score /bin/kube-score && \
  curl -LO https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz && \
  tar xvzf kubeval*.tar.gz && \
  chmod 775 kubeval && \
  mv /tmp/kubeval /bin/kubeval && \
  rm /tmp/*
  
  
# Switching to the non-root user
USER k8stools:k8stools
WORKDIR /home/k8stools
