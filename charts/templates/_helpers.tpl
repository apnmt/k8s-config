{{- define "mongodb.uri" -}}
  {{ if eq .Values.mongodb.architecture "replicaset" }}
  {{- printf "mongodb://" -}}
  {{- printf "%s:%s@" $.Values.mongodb.auth.rootUser $.Values.mongodb.auth.rootPassword -}}
  {{- range $mongocount, $e := until (.Values.mongodb.replicaCount|int) -}}
    {{- printf "%s-mongodb-%d." $.Release.Name $mongocount -}}
    {{- printf "%s-mongodb-headless.%s:%d" $.Release.Name $.Release.Namespace 27017 -}}
    {{- if lt $mongocount  ( sub ($.Values.mongodb.replicaCount|int) 1 ) -}}
      {{- printf "," -}}
    {{- end -}}
  {{- end -}}
  {{ else }}
    {{- printf "mongodb://%s:%s@%s-mongodb.%s:27017" $.Values.mongodb.auth.rootUser $.Values.mongodb.auth.rootPassword $.Release.Name $.Release.Namespace -}}
  {{end}}
{{- end -}}