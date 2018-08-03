pipeline {
   agent any
   triggers {
      pollSCM('H/30 * * * *')
   }
   options {
      buildDiscarder(logRotator(numToKeepStr: '5'))
   }
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
               echo 'Maven testing completed!'
            }
            failure {
               echo 'Maven testing failed.'
            }
         }
      }
      stage('Docker Tag & Push') {
         steps {
            withDockerRegistry([ credentialsId: "dockerhub", url: "http://localhost:5000"]) {
               sh 'docker tag autoopsltd/decmaventest:testing localhost:5000/decmaventest:latest'
               sh 'docker push localhost:5000/decmaventest:latest'
            }
         }
      }
      stage('Build Runnable Container') {
         agent {
            dockerfile {
               reuseNode true
               additionalBuildArgs '--tag autoopsltd/decmaventest:run'
            }
         }
         steps {
            //sh 'mvn -B -DskipTests clean package'
            //sh 'echo "Runnable container created"'
            sh 'unset MAVEN_CONFIG && env && /root/mvnw spring-boot:start'
         }
      }
      stage('Docker Tag & Push Runnable') {
         steps {
            withDockerRegistry([ credentialsId: "dockerhub", url: "http://localhost:5000"]) {
               sh 'docker tag autoopsltd/decmaventest:run localhost:5000/decmaventest:run'
               sh 'docker push localhost:5000/decmaventest:run'
            }
         }
      }
      //stage('Launch Docker Container') {
      //   when {
      //      branch 'master'
      //   }
      //   steps {
      //      sh 'docker-compose up -d'
      //      sh 'docker ps'
      //   }
      //}
   }
   post {
      always {
         echo 'Finshed running "decMavenTest" declarative pipeline job.'
      }
      success {
         echo 'Declarative pipeline job "decMavenTest" completed successfully and without error.'
         mail to: 'autoopsltd@outlook.com',
              from: 'jenkins-admin@admin.com',
              subject: "Successful Pipeline: ${currentBuild.fullDisplayName}",
              body: "Pipeline job completed successfully ${env.BUILD_URL}"
      }
      unstable {
         echo 'Declarative pipeline job "decMavenTest" is unstable - please view the logs.'
         mail to: 'autoopsltd@outlook.com',
              from: 'jenkins-admin@admin.com',
              subject: "Unstable Pipeline: ${currentBuild.fullDisplayName}",
              body: "Unstable - Something is wrong with ${env.BUILD_URL}"
      }
      failure {
         echo 'Declarative pipeline job "decMavenTest" failed - please view the logs.'
         mail to: 'autoopsltd@outlook.com',
              from: 'jenkins-admin@admin.com',
              subject: "Failed Pipeline: ${currentBuild.fullDisplayName}",
              body: "Failed - Something is wrong with ${env.BUILD_URL}"
      }
   }
}













