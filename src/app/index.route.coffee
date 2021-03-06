class States extends Config
  constructor: ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise '/'

    $stateProvider
      .state 'parent',
        abstract: true
        templateUrl: 'app/history/history.html'
        controller: 'historyController'
        controllerAs: 'history'
      .state 'parent.home',
        url: '/'
        parent: 'parent'
        views:
          chatView:
            templateUrl: 'app/history/chat.html',
            controller: 'chatController',
            controllerAs: 'chatController'
          noteView:
            templateUrl: 'app/history/note.html',
            controller: 'noteController',
            controllerAs: 'noteController'
    .state 'parent.chat',
      url: '/chat/:chatId'
      parent: 'parent'
      views:
        chatView:
          templateUrl: 'app/history/chat.html',
          controller: 'chatController',
          controllerAs: 'chatController'
        noteView:
          templateUrl: 'app/history/note.html',
          controller: 'noteController',
          controllerAs: 'noteController'





