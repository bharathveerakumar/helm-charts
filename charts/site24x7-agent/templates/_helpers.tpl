{{/*
Expand the name of the chart.
*/}}
{{- define "site24x7-agent.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "site24x7-agent.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "site24x7-agent.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "site24x7-agent.labels" -}}
helm.sh/chart: {{ include "site24x7-agent.chart" . }}
{{ include "site24x7-agent.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "site24x7-agent.selectorLabels" -}}
app.kubernetes.io/name: {{ include "site24x7-agent.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "site24x7-agent.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "site24x7-agent.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- required "you must provide a serviceAccount.name when serviceAccount.create is not set to true " .Values.serviceAccount.name  }}
{{- end }}
{{- end }}

{{/*
Node Selector labels
*/}}
{{ define "site24x7-agent.nodeSelector" }}
{{- if not (empty .Values.site24x7Agent.nodeSelector) -}}
{{- .Values.site24x7Agent.nodeSelector }}
{{- else -}}
kubernetes.io/os: linux
{{- end }}
{{- end }}
