# testing

This repo is configured to use [node-easymock](https://github.com/CyberAgent/node-easymock) to mock out the kubernetes api calls made by the ansible example playbook.
`node-easymock` needs a data folder containing all the required mocked response files. 
Since we have two test scenarios (upsert and delete), we also have two mock response folders located under mocks called `upsert` and `delete`.

There are a lot of mock responses required due to the behaviour of the kubernetes api where a number of requests are made to discover available apis. These general mock responses can easily be recreated using the supplied `gen-mock` script.

There is a `mock/manual` directory which contains all the test specific crd and resource responses. These need to be updated manually if any of the test resources are changed. :(

