pipeline {
    agent none
    stages {
        stage('Build start') {
            agent any
            steps {
                sh 'echo "Starting the project!"'
            }
        }
        stage('Lint flask python app') {
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
        stage('run docker') {
            agent any
              steps{
                withDockerRegistry([url: "", credentialsId: "bkocisdocker"]){
                sh 'docker run -p 8081:8081 cloud-miniproject-01'
                }
              }
        }		
    }
}
