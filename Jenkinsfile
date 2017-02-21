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

    stage('copy npm cache') {
      sh "cp -r /npm_cache/node_modules node_modules"
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

//    stage('Run e2e tests') {
//      sh "./node_modules/.bin/ng e2e"
//    }

    stage('Build dist artifact') {
      sh "./node_modules/.bin/ng build"
      archiveArtifacts artifacts: 'dist/*.*'
    }
  }
}


