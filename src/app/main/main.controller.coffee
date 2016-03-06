class Main extends Controller
  constructor: ($timeout, @toastr, @Chat, @Message, @$scope, @$log, @$state) ->
    @chats = @Chat.query(@updateSelectedChat)
    @selectedChatName = 'Select chat...'
    @$scope.selectedChatId = null
    @messages = []
    @isOpen = false

    @$scope.changeChat = @changeChat
    @$scope.loadMore = @loadMore

    chatId = @$state.params.chatId
    if chatId?
      @$scope.selectedChatId = chatId
      @toastr.info("selected chat: " + chatId)
      @requestMessages(chatId)

  updateSelectedChat: (data) =>
    chatId = @$state.params.chatId
    if chatId?
      selectedChat = data.filter((chat) -> chat.id == chatId)[0]
      if (selectedChat?)
        @selectedChat = selectedChat
        @selectedChatName = @selectedChat.name

  loadMore:() =>
    last = @messages[-1..][0]
    @Message.loadMore({chatId: @$scope.selectedChatId, toMessageId: last.id}, @appendMessages)

  appendMessages:(data, responseHeaders) =>
    newMessages = data.content
    for message in newMessages
      d = new Date(message.timestamp)
      message.formatted = d.getDate()  + "-" + (d.getMonth()+1) + "-" + d.getFullYear() + " " +
          d.getHours() + ":" + d.getMinutes();
    @messages = @messages.concat newMessages

  changeChat: () =>
    @$state.go("chat", {chatId: @$scope.selectedChatId})

  requestMessages: (chatId) =>
    @Message.query({chatId: chatId}, @showMessages)

  showMessages: (data, responseHeaders) =>
    if (data.content.length > 0)
      @messages = data.content
      for message in @messages
        d = new Date(message.timestamp)
        message.formatted = d.getDate()  + "-" + (d.getMonth()+1) + "-" + d.getFullYear() + " " +
          d.getHours() + ":" + d.getMinutes();

    @$log.info @messages
    return


