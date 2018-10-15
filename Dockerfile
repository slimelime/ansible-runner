FROM myobplatform/shell-operator:0.3.2 as shop

FROM python:3.7-alpine3.8 as py-builder
RUN apk add --no-cache -U git gcc musl-dev libffi-dev openssl-dev make
RUN mkdir /install
WORKDIR /install
COPY opt/ansible-runner/requirements.txt /opt/ansible-runner/requirements.txt
RUN export PYTHONPATH="/install/lib/python3.7/site-packages" && \
    pip install --install-option="--prefix=/install" -r /opt/ansible-runner/requirements.txt

FROM python:3.7-alpine3.8 as base
RUN apk add --no-cache -U curl bash
ENV KUBE_VERSION="v1.11.3"
RUN curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -o /usr/bin/kubectl \
  && chmod +x /usr/bin/kubectl
COPY --from=py-builder /install /usr/local
COPY --from=shop /shell-operator /shell-operator
# Add application last so it would prevent from running excessive build
COPY opt /opt

ENTRYPOINT ["/shell-operator"]
