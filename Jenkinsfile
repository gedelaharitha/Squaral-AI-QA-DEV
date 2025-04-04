pipeline {
    agent none

    environment {
        DOCKER_IMAGE_DEV = "nexus.dtskill.com:8445/squirrelai/dev/frontend"
        DOCKER_IMAGE_QA = "nexus.dtskill.com:8445/squirrelai/qa/frontend"
        DOCKER_IMAGE_PROD = "nexus.dtskill.com:8445/squirrelai/prod/frontend"
        DOCKER_TAG = "${env.BUILD_NUMBER}"
    }

    stages {
        stage('Notify Build Start') {
            steps {
                script {
                    emailext(
                        subject: "STARTED: Build ${env.BUILD_NUMBER} for ${env.BRANCH_NAME}",
                        body: "SquirrelAI Frontend the deployment of branch ${env.BRANCH_NAME} has started.\n\nBuild Number: ${env.BUILD_NUMBER}\n",
                        to: 'aboli.shinde@dtskill.com, tejas.patil@dtskill.com'
                    )
                }
            }
        }
        /* 
        stage('SquirrelAI Dev Build & Deployment') {
            when {
                branch 'newdev'
            }
            agent { label 'SquirrelAI-dev' }
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE_DEV}:v${DOCKER_TAG} . --no-cache"
                    sh "docker push ${DOCKER_IMAGE_DEV}:v${DOCKER_TAG}"
                    sh "sleep 5"
                    sh "docker rm -f squirrelai-frontend"
                    sh "docker run -d --name squirrelai-frontend -p 3000:3000 ${DOCKER_IMAGE_DEV}:v${DOCKER_TAG}"
                }
            }
        }

        stage('SquirrelAI QA Build & Deployment') {
            when {
                branch 'qa'
            }
            agent { label 'Squirrelai-QA' }
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE_QA}:v${DOCKER_TAG} . --no-cache"
                    sh "docker push ${DOCKER_IMAGE_QA}:v${DOCKER_TAG}"
                    sh "sleep 5"
                    sh "docker rm -f squirrelai-frontend"
                    sh "docker run -d --name squirrelai-frontend -p 3000:3000 ${DOCKER_IMAGE_QA}:v${DOCKER_TAG}"
                }
            }
        }
        */
        stage('SquirrelAI Prod Build & Deployment') {
            when {
                branch 'prod'
            }
            agent { label 'Squirrelai-prod' }
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE_PROD}:v${DOCKER_TAG} . --no-cache"
                    sh "docker push ${DOCKER_IMAGE_PROD}:v${DOCKER_TAG}"
                    sh "sleep 5"
                    sh "docker rm -f squirrelai-frontend"
                    sh "docker run -d --name squirrelai-frontend -p 3000:3000 ${DOCKER_IMAGE_PROD}:v${DOCKER_TAG}"
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment was successful!'
            emailext(
                subject: "SUCCESS: SquirrelAI Frontend Build ${env.BUILD_NUMBER} for ${env.BRANCH_NAME}",
                body: "The deployment of the frontend branch ${env.BRANCH_NAME} was successful.\n\nBuild Number: ${env.BUILD_NUMBER}\nDocker Image: ${DOCKER_IMAGE_DEV} or ${DOCKER_IMAGE_QA} or ${DOCKER_IMAGE_PROD}:v${DOCKER_TAG}\n\nCheck Jenkins for details.",
                to: 'aboli.shinde@dtskill.com, tejas.patil@dtskill.com'
            )
        }
        failure {
            echo 'Deployment failed!'
            emailext(
                subject: "FAILURE: SquirrelAI Frontend Build ${env.BUILD_NUMBER} for ${env.BRANCH_NAME}",
                body: "The deployment of the frontend branch ${env.BRANCH_NAME} failed.\n\nBuild Number: ${env.BUILD_NUMBER}\nDocker Image: ${DOCKER_IMAGE_DEV} or ${DOCKER_IMAGE_QA} or ${DOCKER_IMAGE_PROD}:v${DOCKER_TAG}\n\nCheck Jenkins for error logs.",
                to: 'aboli.shinde@dtskill.com, tejas.patil@dtskill.com'
            )
        }
    }
}
