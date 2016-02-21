class Main extends Controller
  constructor: ($timeout, @toastr, @Chat, @$scope, @$log) ->
    @chats = @Chat.query()
    @$scope.selectedChatId = null
    @$scope.changeChat = @changeChat

  changeChat: () =>
    @toastr.info("selected chat: " + @$scope.selectedChatId)




