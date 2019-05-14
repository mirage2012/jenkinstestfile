pipeline {
    agent any
    
    options {
        buildDiscarder(logRotator(numToKeepStr:'20'))
        timeout(time:10, unit: 'MINUTES')
        disableConcurrentBuilds()
    }
    environment {
        ELASTIC = credentials('ELASTIC')
    }
   
    stages {
        stage('Deploy Index Templates') { 
            when {
                changeset "indexTemplates.sh"
            }
            steps {
                sh('./indexTemplates.sh')
            }
        }
        stage('Deploy Elastic Roles') {
            when {
                changeset "elasticRoles.py"
            }
            steps {
                sh('./elasticRoles.py')
            }
        }
        stage('Deploy Elastic Role Mappings') { 
            when {
                changeset "elasticRolemapping.sh"
            }
            steps {
                sh('./elasticRolemapping.sh')
            }
        }
    }
}
