# ansible-runner

[![Build Status](https://travis-ci.org/MYOB-Technology/ansible-runner.svg?branch=master)](https://travis-ci.org/MYOB-Technology/ansible-runner)

*ansible-runner* is a framework for [shell-operator](https://github.com/MYOB-Technology/shell-operator).
It provides a standard layout for ansible plays to be executed in response to a kubernetes object update.

## Usage

The `test` directory within this repo provides a working example of how to use the `ansible-runner`.

You will need to build your own container image inheriting from `ansible-runner` image, which contains your custom ansible plays.

The use of two plays is supported. One called `upsert.yml` which is run by the shell-operator in response to a create/update event of a watched crd resource, and one called `delete` which is run when a resource watched by the shell-operator is deleted.

You will need to update the files within the app directory to suit your needs, then build and publish your own container image. A short description of each file is shown below.

```
.
├── app
│   ├── crd.yaml          # optional if using a crd and may want to reference in shell-config
│   ├── delete.yml        # ansible play - required. Task to be run on a delete resource
│   ├── shell-config.yaml # shell-operator configuration - required
│   └── upsert.yml        # ansible play - required
└── Dockerfile            # docker image containing contents of `app` directory

```

When writing your upsert.yml play, the ansible variable `k8s_resource` will be available for use. All object fields will be accessible therefore under `k8s_resource.spec`.

Once you have built and published your ansible-runner image, you can deploy it to your kubernetes cluster, create and delete resources that shell-operator is configured to watch, and see that your ansible plays are executed in response.

