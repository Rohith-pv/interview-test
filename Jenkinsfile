
pipeleine{

    agent any

    environment {
       IMAGE_NAME= "secure-nginx"
       IMAGE_VERSION = "1.19-${BUILD_NUMBER}"
       DOCKER_REGISTRY= "hub.docker.com"
       KUBERNETES_NAMESPACE="nginx-app"
       KUBECONFIG_PATH="/root/.kube/config"
    }

    stages{
        stage('Checkout code'){
           steps {
             script {

               echo "Checking out the repo"
               checkout scm
             }
           }
        }
        stage('image_build'){
          steps {
            script {
              echo "Building docker image"
              sh """
                  docker build -t $DOCKER_REGISTRY/$IMAGE_NAME:$IMAGE_VERSION .

              """
            }
          }
        }
        stage('security_scan'){
          steps{
            script{
              echo "Runing security scan"
              sh """
                  trivy image --exit-code 1 --severity HIGH $DOCKER_REGISTRY/$IMAGE_NAME:$IMAGE_VERSION
              """
            }
          }
        }
        stage ('pusing_registry'){
          steps{
            withDockerRegistry([credentialsId: 'docker-hub-cred', url: 'https://index.docker.io/v1/']){
              script {
                echo "Pusing image"
                sh """
                    docker push $DOCKER_REGISTRY/$IMAGE_NAME:$IMAGE_VERSION
                """
              }
            }
          
          }
        }
         stage('deployment'){
           steps{
             script{
               echo "Deploy app"
               sh """
                  kubectl --kubeconfig=$KUBERCONFIG_PATH apply -f statefulset.yaml
                  kubectl --kubeconfig=$KUBERCONFIG_PATH set image statefulset/nginx nginx=$DOCKER_REGISTRY/$IMAGE_NAME:$IMAGE_VERSION -n $KUBERNETES_NAMESPACE                 
               """
             }
           }
         }
         stage('verify_deploy')
            steps {
              script {
                echo "Verify deploy"
                sh """
                   kubectl --kubeconfig=$KUBERCONFIG_PATH rollout status statefulset/nginx -n $KUBERENTES_NAMESPACE
                """
              }
              
            }
    }
  
}
