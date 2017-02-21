def image
def imageName = "slapers/tpb"
def imageTag = "${env.BUILD_ID}"

node {

  // Wipe the workspace so we are building completely clean
  deleteDir()

  stage('Checkout') {
    checkout scm
  }

  stage('Build image') {
    image = docker.build "${imageName}:${imageTag}", '--pull .'
  }

  image.inside() {

    stage('Link npm cache') {
      sh "ln -s /npm_cache/node_modules node_modules"
    }

    stage('Run linting') {
      sh "./node_modules/.bin/ng lint"
    }

    stage('Run unittests') {
      try {
        sh "./node_modules/.bin/ng test --watch=false --reporter=progress,junit"
      }
      finally {
        step([$class: 'JUnitResultArchiver', testResults: 'test-results.xml'])
      }
    }
  }
}


