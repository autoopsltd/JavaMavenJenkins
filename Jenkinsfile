pipeline {
   agent any
   stages {
      stage('Maven Build') {
         agent {
            dockerfile {
               reuseNode true
               additionalBuildArgs '--tag autoopsltd/decmaventest:testing'
               args '-v $HOME/.m2:/root/.m2'
            }
         }
         steps {
            sh 'mvn -B -DskipTests clean package'
         }
         post {
            success {
               echo 'Maven packaging worked!'
               archiveArtifacts artifacts: '**/target/*.war, **/target/*.jar'
            }
         }
      }
      stage('Maven Test') {
         agent {
            dockerfile {
               reuseNode true
               additionalBuildArgs '--tag autoopsltd/decmaventest:testing'
               args '-v $HOME/.m2:/root/.m2'
            }
         }
         steps {
            sh 'mvn test'
         }
         post {
            success {
               junit '**/target/surefire-reports/*.xml'
               echo 'Maven testing passed!'
            }
            failure {
               echo 'Maven testing failed.'
            }
         }
      }
      stage('Docker Tag & Push') {
         steps {
            withDockerRegistry([ credentialsId: "dockerhub", url: "http://192.168.1.15:5000"]) {
               sh 'docker tag autoopsltd/decmaventest:testing autoopsltd/decmaventest:latest'
               sh 'docker push autoopsltd/decmaventest:latest'
            }
         }
      }
   }
}













