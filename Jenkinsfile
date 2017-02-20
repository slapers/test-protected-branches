def image
def imageName="slapers/tpb"
def imageTag="${env.BUILD_ID}"

node {

  stage('Checkout'){
    checkout scm
  }

  stage('Build image') {
    image = docker.build "${imageName}:${imageTag}", '--pull .'
  }

  stage('Test image') {
    image.inside() {
      sh "ng test --watch=false --reporter=progress,junit"
    }
  }

}
