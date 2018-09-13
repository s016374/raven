pipeline {
  parameters {
    string(defaultValue: 'registry.innodealing.com', description: 'HARBOR', name: 'HARBOR')
    string(defaultValue: 'ruby/raven', description: 'IMAGE_SIDECAR', name: 'IMAGE_SIDECAR')
  }

  agent {
    node {
      label "docker"
      customWorkspace "workspace/${env.JOB_NAME}"
    }
  }

  stages {
    stage("Package") {
      steps {
        writeFile file: 'Dockerfile',
        text: """FROM ${params.HARBOR}/${params.IMAGE_SIDECAR}
ADD . ."""
        sh "docker build -t ${params.HARBOR}/build_v2/raven ${env.WORKSPACE}"
        sh "docker push ${params.HARBOR}/build_v2/raven"
      }
    }
    stage("Test") {
      steps {
        writeFile file: "raven.yaml",
        text: """apiVersion: batch/v1
kind: Job
metadata:
  name: raven
  namespace: qa
  labels:
    project: raven
    own: dgg
    environment: ${params.STAGE}
    tier: api
    run: testing
spec:
  template:
    metadata:
      labels:
        project: raven
        own: dgg
        environment: ${params.STAGE}
        tier: api
        run: testing
    spec:
      nodeSelector:
        beta.kubernetes.io/dm.projects: "true"
      imagePullSecrets:
        - name: dm-registry-secret
      restartPolicy: Never
      containers:
      - name: raven
        image: ${params.HARBOR}/build_v2/raven
        env:
        - name: BASE_URL
          value: "https://r.qa.innodealing.com"
        - name: JMETER_JTL
          value: "reports/jmeter.jtl"
        - name: JMETER_COUNT
          value: "100"
        - name: JMETER_RAMPUP
          value: "1"
        - name: JMETER_LOOPS
          value: "10"
        - name: FIREMAN_REPORT
          value: "true"
        resources:
          requests:
            memory: "100Mi"
            cpu: "60m"
          limits:
            memory: "600Mi"
            cpu: "600m"
        command: ["sh","-c","bundle && bundle exec cucumber"]"""
        sh "kubectl create -f raven.yaml"
      }
    }
  }
}
