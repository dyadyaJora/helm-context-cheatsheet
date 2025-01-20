{{- define "my.first.template" -}}
simple_key: simple_value
{{- if and (not (empty .)) (not (empty .Chart))  }}
chart_name: {{ .Chart.Name }}
{{- end }}
{{- if and (not (empty .)) (not (empty .a))  }}
a: {{ .a }}
{{- end }}
{{- end -}}

{{- define "my.second.template" -}}
{{ $var := "my string var" }}
x: {{ $var | quote }}
nested: {{ include "my.second.template.nested" (dict "var" $var "Chart" .Chart) | nindent 2 }}
{{- end -}}


{{- define "my.second.template.nested" -}}
x: {{ .var | quote }}
isNested: true
chartName: {{ .Chart.Name }}
{{- end -}}

{{- define "my.third.template" -}}
{{ $id := (randAlphaNum 5) }}
id: {{ $id | quote }}
servers: {{ include "my.third.template.servers" (dict "id" $id "Values" .Values) }}
{{- end -}}

{{- define "my.third.template.servers" -}}
{{- $hosts := .Values.hosts -}}
{{- range $i, $host := $hosts }}
- id: {{ $.id }}-{{ $i }}
  host: {{ $host }}
{{- end }}
{{- end -}}
