class Index extends Run
  constructor: ($log, $http) ->
    $log.debug 'runBlock end'
    $http.defaults.headers.common["X-WA-KEY"] = "marvin_at_beolnix_plugin"
    $http.defaults.headers.common["X-WA-AUTH"] = "8oiDujYDTgeXLUKvgLZWVXdfaxGLovdvnvZ7YtUXgyNbrysMPn"
