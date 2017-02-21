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

  stage('Run unit tests') {
    try {
      image.inside() {
        sh "cd /site && ng test --watch=false --reporter=progress,junit"
      }
    }
    catch (err) {
      throw err
    }
    finally {
      step([$class: 'JUnitResultArchiver', testResults: '/site/test-results.xml'])
    }
  }

}
