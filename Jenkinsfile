pipeline {
   agent any
   tools {
      maven 'myMaven'
      jdk 'myJDK'
   }
   stages {
      stage('Build') {
         steps {
            sh 'mvn install'
         }
         post {
            success {
               junit 'target/surefire-reports/**/*.xml'
            }
         }
      }
   }
}
