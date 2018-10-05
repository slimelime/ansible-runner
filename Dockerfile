FROM myobplatform/shell-operator:0.1.0 as shop

FROM python:3.6-alpine
RUN apk add --no-cache -U curl bash git gcc musl-dev libffi-dev openssl-dev make
ENV KUBE_VERSION="v1.11.3"
RUN curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -o /usr/bin/kubectl \
 && chmod +x /usr/bin/kubectl
# Add application last so it would prevent from running excessive build
COPY opt/ansible-runner/requirements.txt /opt/ansible-runner/requirements.txt
RUN pip install -r /opt/ansible-runner/requirements.txt
COPY --from=shop /shell-operator /shell-operator
COPY opt /opt

ENTRYPOINT ["/shell-operator"]
