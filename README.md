# ansible-runner

[![Build Status](https://travis-ci.org/MYOB-Technology/ansible-runner.svg?branch=master)](https://travis-ci.org/MYOB-Technology/ansible-runner)

*ansible-runner* is a framework for [shell-operator](https://github.com/MYOB-Technology/shell-operator).
It provides a standard layout for ansible playbooks to be executed in response to an kubernetes object update.

## Run the example

Run the shell-operator watching an example crd with a provided example ansible role to execute upon update of any example resource updates.

* authenticate to your kubernetes cluster
* run the operator locally (outside of the cluster)
    ```
    docker-compose run --rm example
    ```
* create an example resource
    ```
    kubectl apply -f templates/example-resource.yaml
    ```
* behold the ansible wonders that fill your screen

