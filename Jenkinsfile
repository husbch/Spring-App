pipeline {
    
    agent any
    
    environment {
        remStage = "sshpass -p xxxxx ssh root@xxx.xxx.xxx.xxx"
        remProduction = "sshpass -p xxxxx ssh root@xxx.xxx.xxx.xxx"
    }
    
    stages {
        stage('Clone') {
            steps {
                git branch: 'master', credentialsId: 'cred-gitlab', url: 'https://git.xxxxxxxxxxx.com/learning/learning-husni.git'
            }
        }
        
        stage('Build') {
            steps {
                sh './gradlew build'
                sh 'docker build -t registry.xxxxxxxxxxx.com/learning/spring-app .'
            }
        }
        
        stage('Push') {
            steps {
                sh 'docker login registry.xxxxxxxxxxx.com -u Husni -p xxxxxxxx'
                sh 'docker push registry.xxxxxxxxxxx.com/learning/spring-app'
            }
        }
        
        stage('Stage') {
            steps {
                sh '${remStage} docker rm -f spring-app'
                sh '${remStage} docker image rm registry.xxxxxxxxxxx.com/learning/spring-app'
                sh '${remStage} docker run --name spring-app -dit -p 2020:8080 registry.xxxxxxxxxxx.com/learning/spring-app'
            }
        }
        
        stage('Production') {
            steps {
                sh '${remProduction} docker rm -f spring-app'
                sh '${remProduction} docker image rm registry.xxxxxxxxxxx.com/learning/spring-app'
                sh '${remProduction} docker run --name spring-app -dit -p 2020:8080 registry.xxxxxxxxxxx.com/learning/spring-app'
            }
        }
    }
}
