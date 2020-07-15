pipeline {
    
    agent any
    
    environment {
        remStage = "sshpass -p admin ssh root@34.87.128.241"
        remProduction = "sshpass -p admin ssh root@35.247.166.245"
    }
    
    stages {
        stage('Clone') {
            steps {
                git branch: 'master', credentialsId: 'cred-gitlab', url: 'https://git.infosyssolusiterpadu.com/learning/learning-husni.git'
            }
        }
        
        stage('Build') {
            steps {
                sh './gradlew build'
                sh 'docker build -t registry.infosyssolusiterpadu.com/learning/spring-app .'
            }
        }
        
        stage('Push') {
            steps {
                sh 'docker login registry.infosyssolusiterpadu.com -u Husni -p Husnibakrie1'
                sh 'docker push registry.infosyssolusiterpadu.com/learning/spring-app'
            }
        }
        
        stage('Stage') {
            steps {
                sh '${remStage} docker rm -f spring-app'
                sh '${remStage} docker run --name spring-app -dit -p 2020:8080 registry.infosyssolusiterpadu.com/learning/spring-app'
            }
        }
        
        stage('Production') {
            steps {
                sh '${remProduction} docker rm -f spring-app'
                sh '${remProduction} docker run --name spring-app -dit -p 2020:8080 registry.infosyssolusiterpadu.com/learning/spring-app'
            }
        }
    }
}