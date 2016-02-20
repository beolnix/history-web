class Main extends Controller
  constructor: ($timeout, toastr, @Chat) ->
    @toastr = toastr
    @activate()

  activate: () =>
    @chats = @Chat.query()




