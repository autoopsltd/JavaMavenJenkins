pipeline {
   agent any
   tools {
      maven 'myMaven'
      jdk 'myJDK'
   }
   stages {
      stage('Build') {
         steps {
            sh 'mvn -B -DskipTests clean package'
         }
         post {
            success {
               echo 'Maven packaging worked!'
            }
         }
      }
      stage('Test') {
         steps {
            sh 'mvn test'
         }
         post {
            always {
               junit 'target/surefire-reports/*.xml'
            }
         }
      }
   }
}
