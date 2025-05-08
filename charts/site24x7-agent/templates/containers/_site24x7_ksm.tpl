{{- define "site24x7.kube-state-metrics" -}}
{{- with .Values.site24x7KubeStateMetrics.image -}}
- image: {{ .repository | default "site24x7" }}/{{ .repository | default "site24x7" }}:{{ .tag }}
  imagePullPolicy: {{ .pullPolicy }}
{{- end }}
  name: site24x7-kube-state-metrics
  livenessProbe:
    httpGet:
        path: /healthz
        port: 8080
    initialDelaySeconds: 5
    timeoutSeconds: 5
  readinessProbe:
    httpGet:
        path: /
        port: 8081
    initialDelaySeconds: 5
    timeoutSeconds: 5
  ports:
  - containerPort: 8080
    name: http-metrics
  - containerPort: 8081
    name: telemetry
  securityContext:
    allowPrivilegeEscalation: false
    capabilities:
      drop:
       - ALL
    readOnlyRootFilesystem: true
    runAsNonRoot: true
    runAsUser: 1001080000
    seccompProfile:
      type: RuntimeDefault
{{- end }}