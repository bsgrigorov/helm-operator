{{- define "name" -}}
{{- .Chart.Name -}}
{{- end -}}

{{- define "fullname" -}}
{{- printf "%s-%s" .Chart.Name .Release.Name -}}
{{- end -}}
