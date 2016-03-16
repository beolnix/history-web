class Note extends Controller
  constructor: ($timeout, @toastr, @Chat, @Message, @$scope, @$log, @$state) ->
    @chats = @Chat.query(@updateSelectedChat)
    @selectedChatName = 'Select chat...'
    @$scope.selectedChatId = null
    @messages = []
    @isOpen = false




