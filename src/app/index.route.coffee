class States extends Config
  constructor: ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise '/'

    $stateProvider
      .state 'home',
        url: '/'
        templateUrl: 'app/main/main.html'
        controller: 'mainController'
        controllerAs: 'main'
      .state 'chat',
        url: '/chat/:chatId'
        templateUrl: 'app/main/main.html'
        controller: 'mainController'
        controllerAs: 'main'



