def image
def imageName = "slapers/tpb"
def imageTag = "${env.BUILD_ID}"

node {

  stage('Checkout') {
    checkout scm
  }

  stage('Build image') {
    image = docker.build "${imageName}:${imageTag}", '--pull .'
  }

  stage('Inside image') {

    image.inside() {

      stage('Link npm cache') {
        sh "ln -s /npm_cache/node_modules node_modules"
      }

      stage('Run unittests') {
        try {
          sh "npm run ng test --watch=false --reporter=progress,junit"
        }
        finally {
          step([$class: 'JUnitResultArchiver', testResults: 'test-results.xml'])
        }
      }
    }
  }
}


