{{/*
Expand the name of the chart.
*/}}
{{- define "fedco-devcentral-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "fedco-devcentral-app.fullname" -}}
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
{{- define "fedco-devcentral-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "devcentral.name" -}}
{{- printf "%s" .Values.deployment.name -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "fedco-devcentral-app.labels" -}}
helm.sh/chart: {{ include "fedco-devcentral-app.chart" . }}
app: {{ .Values.deployment.name }}
{{ include "fedco-devcentral-app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "devcentral.labels" -}}
app: {{ .Values.deployment.name }}
{{- end }}


{{/*
Selector labels
*/}}
{{- define "fedco-devcentral-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "fedco-devcentral-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fedco-devcentral-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "fedco-devcentral-app.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
