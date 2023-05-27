pipeline {
 agent {
    node {
      label 'go'
    }
  }



    environment {
        REGISTRY = 'registry.cn-beijing.aliyuncs.com/pox'
        APP_NAME = 'zkevm-sequencer'
    }

  stages {
       stage('check out from git') {
               steps {
                 checkout([$class: 'GitSCM',
                 branches: [[name: 'release/v12.x.x']],
                 extensions: [[$class: 'SubmoduleOption',
                 disableSubmodules: false,
                 parentCredentials: true,
                 recursiveSubmodules: true,
                 reference: '', trackingSubmodules: true]],
                 userRemoteConfigs: [[credentialsId: 'gitaccount', url: 'http://git.everylink.ai/crosschain/sequencer']]])
               }
       }
    stage('build & push') {
      steps {
        container('go') {
          withCredentials([usernamePassword(passwordVariable : 'DOCKER_PASSWORD' ,credentialsId : 'dockerhub' ,usernameVariable : 'DOCKER_USERNAME' ,)]) {
            sh 'echo "$DOCKER_PASSWORD" | docker login $REGISTRY -u "$DOCKER_USERNAME" --password-stdin'
            sh 'docker build -f Dockerfile -t $REGISTRY/$APP_NAME:SNAPSHOT-$BUILD_NUMBER .'
            sh 'docker push $REGISTRY/$APP_NAME:SNAPSHOT-$BUILD_NUMBER'
           }
         }
      }
    }
    stage('deploy to sandbox') {
      steps {
       container ('go') {
                                 withCredentials([
                                     kubeconfigFile(
                                     credentialsId: 'kubeconfig',
                                     variable: 'KUBECONFIG')
                                     ]) {
                                     sh 'envsubst < deploy/prover/sandbox/deployment.yaml | kubectl apply -f -'
                                     sh 'envsubst < deploy/prover/sandbox/service.yaml | kubectl apply -f -'
                                 }
                            }
      }
    }

  }
}

