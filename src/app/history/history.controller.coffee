class History extends Controller
  constructor: ($timeout, @toastr, @Chat, @Message, @$scope, @$log, @$state) ->
    @chats = @Chat.query(@updateSelectedChat)
    @selectedChatName = 'Select chat...'
    @$scope.selectedChatId = null
    @messages = []
    @isOpen = false

    @$scope.changeChat = @changeChat
    @$scope.loadMore = @loadMore

    chatId = @$state.params.chatId
#    if chatId?
#      @$scope.selectedChatId = chatId
#      @toastr.info("selected chat: " + chatId)
#      @requestMessages(chatId)

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


  changeChat: () =>
    @$state.go("chat", {chatId: @$scope.selectedChatId})




