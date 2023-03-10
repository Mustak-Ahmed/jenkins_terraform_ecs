pipeline {
     environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

	agent{
		docker {image 'hashicorp/terraform'}
	}
    stages {
         stage('ecr push') {
            steps {     
		sh 'aws ecr get-login-password --region ap-south-1 | sudo docker login --username AWS --password-stdin 879580385544.dkr.ecr.ap-south-1.amazonaws.com'
	        sh 'sudo docker build -t jenkins-ecr:v${BUILD_NUMBER} -t jenkins-ecr:latest .'
	        sh 'sudo docker tag jenkins-ecr:v${BUILD_NUMBER} 879580385544.dkr.ecr.ap-south-1.amazonaws.com/jenkins-ecr:v${BUILD_NUMBER}'
		sh 'sudo docker tag jenkins-ecr:v${BUILD_NUMBER} 879580385544.dkr.ecr.ap-south-1.amazonaws.com/jenkins-ecr:latest'
	        sh 'sudo docker push 879580385544.dkr.ecr.ap-south-1.amazonaws.com/jenkins-ecr:v${BUILD_NUMBER}'
		sh 'sudo docker push 879580385544.dkr.ecr.ap-south-1.amazonaws.com/jenkins-ecr:latest'
            }
        }
        stage('Plan') {
            steps {
                sh 'terraform init'
                sh "terraform plan"
            }
        }
       stage ('Apply infrastructure'){
  	input{
   		 message "Do you want to proceed for applying the resources?"
  	}
    	steps {
                sh 'terraform apply -auto-approve'

              }
        }
	stage ('Destroy infrastructure'){
  	input{
   		 message "Do you want to proceed for destroy the resources?"
  	}
    	steps {
                sh 'terraform destroy -auto-approve'

              }
        }
    }

  }
