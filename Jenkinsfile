pipeline {
    agent any

    options {
        timeout(time: 30, unit: 'MINUTES')
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    runWithWrappers {
                        echo '=== STAGE: Checkout ==='
                        checkout scm
                    }
                }
            }
        }

        stage('Clean Workspace') {
            steps {
                script {
                    runWithWrappers {
                        echo '=== STAGE: Clean Workspace ==='
                        try {
                            echo 'Attempting to clean workspace using Workspace Cleanup Plugin...'
                            cleanWs()
                        } catch (groovy.lang.MissingMethodException | java.lang.NoSuchMethodError e) {
                            echo 'Workspace Cleanup Plugin not found. Falling back to deleteDir()...'
                            deleteDir()
                        }
                        
                        echo 'Restoring workspace files via checkout...'
                        checkout scm
                    }
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    runWithWrappers {
                        echo '=== STAGE: Build ==='
                        // Compile code using the Maven Wrapper (mvnw.cmd)
                        bat 'mvnw.cmd clean compile'
                    }
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    runWithWrappers {
                        echo '=== STAGE: Test ==='
                        // Run unit tests using the Maven Wrapper (mvnw.cmd)
                        bat 'mvnw.cmd test'
                    }
                }
            }
        }

        stage('Package') {
            steps {
                script {
                    runWithWrappers {
                        echo '=== STAGE: Package ==='
                        // Package the application into a JAR file, skipping tests since they just ran in the previous stage
                        bat 'mvnw.cmd package -DskipTests'
                    }
                }
            }
        }

        stage('Archive Artifacts') {
            steps {
                script {
                    runWithWrappers {
                        echo '=== STAGE: Archive Artifacts ==='
                        // Archive the generated JAR file in the target directory
                        archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                runWithWrappers {
                    echo '=== Post Action: Always ==='
                    echo 'Jenkins Pipeline build execution has completed.'
                }
            }
        }
        success {
            script {
                runWithWrappers {
                    echo '=== Post Action: Success ==='
                    echo 'SUCCESS: The build finished successfully!'
                }
            }
        }
        failure {
            script {
                runWithWrappers {
                    echo '=== Post Action: Failure ==='
                    echo 'FAILURE: The build failed. Please inspect the stage logs above for errors.'
                }
            }
        }
    }
}

/**
 * Helper method to wrap execution with ansiColor and timestamps.
 * Catches MissingMethodException or NoSuchMethodError if the plugins are not installed,
 * falling back gracefully to plain output.
 */
def runWithWrappers(Closure body) {
    def hasAnsi = false
    try {
        ansiColor('xterm') {}
        hasAnsi = true
    } catch (groovy.lang.MissingMethodException | java.lang.NoSuchMethodError e) {}

    def hasTime = false
    try {
        timestamps {}
        hasTime = true
    } catch (groovy.lang.MissingMethodException | java.lang.NoSuchMethodError e) {}

    if (hasAnsi && hasTime) {
        ansiColor('xterm') {
            timestamps {
                body()
            }
        }
    } else if (hasAnsi) {
        ansiColor('xterm') {
            body()
        }
    } else if (hasTime) {
        timestamps {
            body()
        }
    } else {
        body()
    }
}
