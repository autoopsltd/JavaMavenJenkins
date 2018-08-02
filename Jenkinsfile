pipeline {
   agent any
   tools {
      maven 'myMaven'
      jdk 'myJDK'
   }
   stages {
      stage('Build') {
         steps {
            sh 'mvn -Dmaven.test.failure.ignore=true install'
         }
         post {
            success {
               junit 'target/surefire-reports/**/*.xml'
            }
         }
      }
   }
}
