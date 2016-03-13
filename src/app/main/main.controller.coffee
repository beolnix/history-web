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
      message.formatted = @getFormattedDate(message.timestamp)
    @messages = @messages.concat newMessages

  changeChat: () =>
    @$state.go("chat", {chatId: @$scope.selectedChatId})

  requestMessages: (chatId) =>
    @Message.query({chatId: chatId}, @showMessages)

  showMessages: (data, responseHeaders) =>
    if (data.content.length > 0)
      @messages = data.content
      for message in @messages
        message.formatted = @getFormattedDate(message.timestamp)

  selectMessage: (msgId, type, $event) =>
    elem = $event.currentTarget
    active = elem.getAttribute("class").indexOf("active") > -1
    if active
      newClassAttr = elem.getAttribute("class").replace("btn-default", "")
      if "question" == type
        newClassAttr = newClassAttr + " btn-warning"
      else
        newClassAttr = newClassAttr + " btn-primary"
      elem.setAttribute("class", newClassAttr)
    else
      newClassAttr = elem.getAttribute("class")
        .replace("btn-warning", "")
        .replace("btn-primary", "") + " btn-default"
      elem.setAttribute("class", newClassAttr)
    @switchToDefault($event.currentTarget, type)

  switchToDefault: (elem, type) =>
    if "question" == type
      def = elem.parentElement.children[1]
      newClassAttr = def.getAttribute("class")
        .replace("btn-warning", "")
        .replace("btn-primary", "") + " btn-default"
      def.setAttribute("class", newClassAttr)
    else
      def = elem.parentElement.children[0]
      newClassAttr = def.getAttribute("class")
        .replace("btn-warning", "")
        .replace("btn-primary", "") + " btn-default"
      def.setAttribute("class", newClassAttr)


  removeMessage: (msgId, type) =>
    #

  addMessage: (msg, type) =>

  getFormattedDate: (timestamp) ->
    d = new Date(timestamp)
    return d.getDate()  + "." + (d.getMonth()+1) + "." + d.getFullYear() + " " +
      d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds()

    @$log.info @messages
    return


