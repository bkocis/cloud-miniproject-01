
# Building and deploying flask apps using Jenkins and Kubernetes 

This repo is for exercise only and contain Jenkinsfiles for dockerizing and running flask apps in various ways. The repo has multiple branches for various scenarios: 

- __branch test-docker__
	The Jenkins builds the dokcer image, and runs it on the same instance. In this case the last stage is open untill the build is not stopped. The app can be available from the public address url of the instance and the defined port. 

- __branch test-kubernetes__
	The build in this branch defines a kubernetes cluster in one stage of the jenkins build, and in another one deploys the defined docker image. After the last stage is finished, the app that is now running in the kubernetes cluster, can be reached via the load balancer's public address (and defined port). 

