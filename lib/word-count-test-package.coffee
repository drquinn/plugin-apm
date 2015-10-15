WordCountTestPackageView = require './word-count-test-package-view'
{CompositeDisposable} = require 'atom'

module.exports = WordCountTestPackage =
  wordCountTestPackageView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @wordCountTestPackageView = new WordCountTestPackageView(state.wordCountTestPackageViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @wordCountTestPackageView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'word-count-test-package:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @wordCountTestPackageView.destroy()

  serialize: ->
    wordCountTestPackageViewState: @wordCountTestPackageView.serialize()

  toggle: ->
    console.log 'WordCountTestPackage APMx was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      editor = atom.workspace.getActiveTextEditor()
      words = editor.getText().split(/\s+/).length
      @wordCountTestPackageView.setCount(words)
      @modalPanel.show()
