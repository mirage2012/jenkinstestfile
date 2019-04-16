pipeline {
    agent any
    
    options {
        buildDiscarder(logRotator(numToKeepStr:'20'))
        timeout(time:10, unit: 'MINUTES')
        disableConcurrentBuilds()
    }
    
    stages {
        stage('Deploy Index Templates') { 
            when {
                changeset "indexTemplates.sh"
            }
            steps {
                sh(./indexTemplates.sh)
            }
        }
        stage('Deploy Elastic Roles') {
            when {
                changeset "elasticRoles.sh"
            }
            steps {
                sh(./elasticRoles.sh)
            }
        }
        stage('Deploy Elastic Role Mappings') { 
            when {
                changeset "elasticRolemapping.sh"
            }
            steps {
                sh(./elasticRolemapping.sh)
            }
        }
    }
}
