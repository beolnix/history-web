class Note extends Controller
  constructor: ($timeout, @toastr, @Chat, @Message, @$scope, @$log, @$state, @$rootScope) ->
    @questions = []
    @answers = []

    @$rootScope.$on('chat.removeMessageFromNote', @removeMessageFromNote)
    @$rootScope.$on('chat.addMessageToNote', @addMessageToNote)

  removeMessageFromNote: (event, data) =>
    @$log.info('remove message: ' + data.msg.id)
    if "question" == data.type
      @questions = @questions.filter (msg) -> msg.id != data.msg.id
    else
      @answers = @answers.filter (msg) -> msg.id != data.msg.id


  addMessageToNote: (event, data) =>
    @$log.info('add message: ' + data.msg.id)
    collection = @resolveCollectionByType(data.type)
    collection.push data.msg
    collection.sort (a,b) ->
      return if a.timestamp >= b.timestamp then 1 else -1

  resolveCollectionByType: (type) =>
    if "question" == type
      return @questions
    else
      return @answers

  removeMsgFromCollection: (msg, collection) =>









