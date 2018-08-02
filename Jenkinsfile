pipeline {
   agent any
   tools {
      maven 'myMaven'
      jdk 'myJDK'
   }
   stages {
      stage('Build') {
         agent {
            docker {
               image 'maven:alpine'
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
      stage('Test') {
         agent {
            docker {
               image 'maven:alpine'
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
   }
}
