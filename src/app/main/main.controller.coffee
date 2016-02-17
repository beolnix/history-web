class Main extends Controller
  constructor: ($timeout, webDevTecService, toastr) ->
    @awesomeThings = []
    @classAnimation = ''
    @creationDate = 1454622044688
    @webService = webDevTecService
    @timeout = $timeout
    @activate()
    return

  activate: () =>
    @getWebDevTec()
    @timeout (->
      classAnimation = 'rubberBand'
      return
    ), 4000
    return

  showToastr: () =>
    toastr.info 'Fork <a href="https://github.com/Swiip/generator-gulp-angular" target="_blank"><b>generator-gulp-angular</b></a>'
    @classAnimation = ''
    return

  getWebDevTec: () =>
    @awesomeThings = @webService.getTec()
    angular.forEach @awesomeThings, (awesomeThing) ->
      awesomeThing.rank = Math.random()
      return
    return


