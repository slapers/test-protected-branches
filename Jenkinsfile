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
        sh "cp -r /npm_cache/node_modules node_modules"
        sh "ng test --watch=false --reporter=progress,junit"
      }
    }
    finally {
      step([$class: 'JUnitResultArchiver', testResults: 'test-results.xml'])
    }
  }

}
