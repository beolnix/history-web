class Main extends Controller
  constructor: ($timeout, @toastr, @Chat, @Message, @$scope, @$log, @$state) ->
    @chats = @Chat.query()
    @$scope.selectedChatId = null
    @messages = []

    @$scope.changeChat = @changeChat

    chatId = @$state.params.chatId
    if chatId?
      @$scope.selectedChatId = chatId
      @toastr.info("selected chat: " + @$scope.selectedChatId)
      @requestMessages()

  changeChat: () =>
    @$state.go("chat", {chatId: @$scope.selectedChatId})


  requestMessages: () =>
    @Message.query({chatId: @$scope.selectedChatId}, @showMessages)

  showMessages: (data, responseHeaders) =>
    if (data.content.length > 0)
      @messages = data.content
      for message in @messages
        d = new Date(message.timestamp)
        message.formatted = d.getDate()  + "-" + (d.getMonth()+1) + "-" + d.getFullYear() + " " +
          d.getHours() + ":" + d.getMinutes();

    @$log.info @messages
    return


