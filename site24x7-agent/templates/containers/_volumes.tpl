{{- define "site24x7-agent.volumes" }}
{{- with .Values -}}
- configMap:
    name: site24x7
    optional: true
  name: clusterconfig
{{- if .site24x7Agent.nonRootSecurityContext }}
- emptyDir: {}
  name: site24x7-agent
{{- end }}
{{- if not (and .site24x7Agent.nonRootSecurityContext .openShift) }}
- hostPath:
    path: /proc
  name: procfs
- hostPath:
    path: /sys/
  name: sysfs
- hostPath:
    path: /var/
  name: varfs
- hostPath:
    path: /etc/
  name: etcfs
{{- end }}
{{- end }}
{{- end }}