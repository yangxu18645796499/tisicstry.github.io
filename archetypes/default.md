---
title: "{{ replace .Name "-" " " | title }}"
{{- $nums := findRE `^\d+` .Name 1 -}}
weight: {{ if gt (len $nums) 0 }}{{ index $nums 0 }}{{ else }}0{{ end }}
---

