{{- define "site24x7-agent.nonRootScc" }}
capabilities:
  drop:
    - ALL
seccompProfile:
  type: RuntimeDefault
allowPrivilegeEscalation: false
readOnlyRootFilesystem: true
runAsNonRoot: true
runAsUser: 1001010001
{{- end }}

{{- define "site24x7-agent.rootScc" }}
runAsUser: 0
readOnlyRootFilesystem: false
{{- end }}

{{- define "site24x7-agent.nodeAgentScc" }}
{{- if .Values.site24x7Agent.nonRootSecurityContext }}
{{- include "site24x7-agent.nonRootScc" . }}
{{- else }}
{{- include "site24x7-agent.rootScc" . }}
{{- end }}
{{- end }}