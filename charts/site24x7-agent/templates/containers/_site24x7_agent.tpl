{{- define "site24x7-agent.container" -}}
{{- with .Values.site24x7Agent.image -}}
- image: {{ .repository | default "site24x7" }}/{{ .repository | default "site24x7" }}:{{ .tag }}
  imagePullPolicy: {{ .pullPolicy }}
{{- end }}
  name: site24x7-agent
  securityContext:
  {{- include "site24x7-agent.nodeAgentScc" . | indent 4 }}
  env:
    - name: KEY
      valueFrom:
        secretKeyRef:
          name: "{{ include "site24x7-agent.fullname" . }}-agent"
          key: KEY
    - name: installer
      value: kubernetes
    - name: NODE_IP
      valueFrom:
        fieldRef:
          fieldPath: status.hostIP
    - name: NODE_NAME
      valueFrom:
        fieldRef:
          fieldPath: spec.nodeName
    - name: NAMESPACE
      valueFrom:
        fieldRef:
          fieldPath: metadata.namespace
    {{- if and .Values.site24x7Agent.nonRootSecurityContext .Values.openShift }}
    - name: SERVERLESS
      value: true
    {{- end }}
  volumeMounts:
    - name: clusterconfig
      mountPath: /etc/site24x7/clusterconfig
      readOnly: true
    {{- if .Values.site24x7Agent.nonRootSecurityContext }}
    - name: site24x7-agent
      mountPath: /opt/site24x7/
    {{- end }}
    {{- if not (and .Values.site24x7Agent.nonRootSecurityContext .Values.openShift) }}
    - name: procfs
      mountPath: /host/proc
      readOnly: true
    - name: sysfs
      mountPath: /host/sys/
      readOnly: true
    - name: varfs
      mountPath: /host/var/
      readOnly: true
    - name: etcfs
      mountPath: /host/etc/
      readOnly: true
    {{- end }}
{{- end }}