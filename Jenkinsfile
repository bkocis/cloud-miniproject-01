pipeline {
    agent none
    stages {
        stage('Build start') {
            agent any
            steps {
                sh 'echo "Starting the project!"'
            }
        }
        stage('Unit test flask app') {
            agent { docker { image 'python:3.7.2' } }
            steps {
                withEnv(["HOME=${env.WORKSPACE}"]) {
                sh '''
                    pip install --upgrade --user pip
                    pip install -r requirements.txt
                    python test.py
                '''
                }
            }
        }
	    stage('Security Scan') {
	        agent any
            steps {
                 aquaMicroscanner imageName: 'alpine:latest', notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'html' 
            }
        }         
	    stage('Building docker image') {
	        agent any
	        steps {
			    sh 'docker build -t cloud-miniproject-01 .'			
	        }
	    }
	    stage('Push docker image to docker-hub') {
	        agent any
		    steps {
			    withDockerRegistry([url: "", credentialsId: "bkocisdocker"]){
			        sh "docker tag cloud-miniproject-01 bkocis/cloud-miniproject-01:latest"
			        sh "docker push bkocis/cloud-miniproject-01:latest"
			    }
            }
		}
        stage('Stat Kubernetes cluster') {
            agent any
            steps {
                withAWS(credentials: 'jenkins3-capstone_user_credentials', region: 'eu-central-1') 
                sh 'aws --version'
                sh 'eksctl version'
                sh 'export PATH=$PATH:$HOME/bin'
                sh 'echo "Starting Kubernetes cluster..."'
                sh 'eksctl create cluster --name cloud-miniproject-01 --version 1.16 --nodegroup-name standard-workers --node-type t2.small --nodes 2 --nodes-min 1 --nodes-max 4 --node-ami auto --region eu-central-1'
            }

        }
        stage('Deploy to AWS EKS') {
            agent any
              steps{
                  withAWS(credentials: 'jenkins3-capstone_user_credentials', region: 'eu-central-1') {
                    sh "aws eks --region eu-central-1 update-kubeconfig --name cloud-miniproject-01"
                    sh "kubectl config use-context arn:aws:eks:eu-central-1:643112058200:cluster/cloud-miniproject-01"
                    sh "kubectl get nodes"
                    sh "kubectl get deployments"
                    sh "kubectl apply -f deployment.yml"
                    sh "kubectl set image deployments/cloud-miniproject-01 cloud-miniproject-01=bkocis/cloud-miniproject-01:latest"
                    sh "kubectl get deployments"
                    sh "kubectl rollout status deployments/cloud-miniproject-01"
                    sh "kubectl get service/cloud-miniproject-01"
                  }
              }
        }		
    }
}
