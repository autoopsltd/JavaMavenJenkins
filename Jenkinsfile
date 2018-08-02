pipeline {
   agent any
   tools {
      maven 'myMaven'
      jdk 'myJDK'
   }
   stages {
      stage('Build') {
         steps {
            sh 'mvn clean package'
         }
      }
   }
}
