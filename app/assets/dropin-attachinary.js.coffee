# $ ->
#   $('.js-s3_file_field').S3FileField
#     remove_completed_progress_bar: false
#     #progress_bar_target: 
#     done: (e, data) -> 
#       alert 'Uploaded ' + content.filename + ' to ' + data.result.url
#       console.log(data.result.url)

#    $('.js-s3_file_field').bind 's3_upload_failed', (e, content) ->
#       alert content.filename + ' failed to upload'

#----
ready = ->
  $('.js-s3_file_field').each ->
   id = $(this).attr('id')
   $this = -> $("##{id}")
   $progress = $(this).siblings('.progress').hide()
   $meter = $progress.find('.meter')
   $(this).S3FileField
    add: (e, data) ->
      $progress.show()
      data.submit()
    done: (e, data) ->
      $progress.hide()
      $this().attr(type: 'text', value: data.result.url, readonly: true)
    fail: (e, data) ->
      reason = data.failReason + ' : ' + data.jqXHR.responseText
      alert reason
    progress: (e, data) ->
      progress = parseInt(data.loaded / data.total * 100, 10)
      $meter.css(width: "#{progress}%")

$(document).ready(ready)
$(document).on('page:load', ready)

#----

(($) ->

  $.dropin = 
    index: 0
    config:
      disableWith: 'Uploading...'
      indicateProgress: true
      # invalidFormatMessage: 'Invalid file format'
      template: """
        <ul>
          <% for(var i=0; i<files.length; i++){ %>
            <li>
              <%= files[i].filename %>
              <a href="#" data-remove="<%= files[i].filename %>">Remove</a>
            </li>
          <% } %>
        </ul>
      """

      render: (files) ->
        $.dropin.Templating.template(@template, files: files)

  $.fn.dropin = (options) ->
    settings = $.extend {}, $.dropin.config, options

    this.each ->
      $this = $(this)

      if !$this.data('dropin-bond')
        $this.data 'dropin-bond', new $.dropin.Dropin($this, settings)

  class $.dropin.Dropin
    constructor: (@input, @config) ->
      @options = @input.data('dropin')
      @files = @options.files

      @$form = @input.closest('form')
      # @$submit = 
      # @$wrapper = 

      @initFileUpload()
      @addFilesContainer()
      @bindEventHandlers()
      @redraw()
      @checkMaximum()

    initFileUpload: ->
      @options.field_name = @input.attr('name')

      options = 
        dataType: 'json'
        paramName: 'file'
        # headers: 
        dropzone: @config.dropZone || @input
        sequentialUploads: true

      # if @$input.attr('accept')
      #   ...

      @$input.fileupload(options)

    bindEventHandlers: ->
      @$input.bind 'fileuploadsend', (event, data) =>
        @$input.addClass 'uploading'
        @$wrapper.addClass 'uploading' if @$wrapper?
        @$form.addClass 'uploading'

        @$input.prop 'disabled', true
        if @config.disabledWith
          @$submit.each (index, input) =>
            $input = $(input)
            $input.data 'old-val', $input.val() unless $input.data('old-val')
          @$submit.val @config.disableWith
          @$submit.prop 'disabled', true

        !@maximumReached()

      @input.bind 'fileuploaddone', (event, data) =>
        @addFile(data, result)

      @input.bind 'fileuploadstart', (event) =>
        # changed on every file upload
        @$input = $(event.target)

      @$input.bind 'fileuploadalways', (event) =>
        @$input.removeClass 'uploading'
        @$wrapper.removeClass 'uploading' if @$wrapper?
        @$form.removeClass 'uploading'

        @checkMaximum()
        if @config.disableWith
          @$submit.each (index, input) =>
            $input = $(input)
            $input.val $input.data('old-val')
          @$submit.prop 'disabled'. false

      @$input.bind 'fileuploadproressall', (e, data) =>
        progress = parseInt(data.loaded / data.total * 100, 10)
        if @config.disableWith && @config.indicateProgress
          @$submit.val "[#{progress}%] #{@config.disableWith}"

    addFile: (file) ->
      if !@options.accept || $.inArray(file.format, @options.accept) != -1 $.inArray(file.resource_type, @options.accept) != -1
        @files.push file
        @redraw()
        @checkMaximum()
        @input.trigger 'dropin:fileadded' [file]
      else
      alert @config.invalidFormatMessage

    removeFile: (fileIdtoRemove) ->
      _files = []
      removedFile = null
      for file in @files
        if file.filename == fileIdtoRemove
          removedFile = file
        else
          _files.push file
      @files = _files
      @redraw()
      @checkMaximum()
      @$input.trigger 'dropin:fileremoved', [removedFile]

    checkMaximum: ->
      if @maximumReached()
        @$wrapper.addClass 'disabled' if @$wrapper?
        @$input.prop('disabled', true)
      else
        @$wrapper.removeClass 'disabled' if @$wrapper?
        @$input.prop('disabled', true)

    maximumReached: ->
      @options.maximum && @files.length >= @options.maximum


    addFilesContainer: ->
      if @options.files_container_selector? and $(@options.files_container_selector).length > 0
        @$filesContainer = $(@options.files_container_selector)
      else
        @$filesContainer = $('<div class="dropin_container">')
          @$input.after @$filesContainer

    redraw: ->
      @$filesContainer.empty()

      if @files.length > 0
        @$filesContainer.append @makeHiddenField(JSON.stringify(@files))

        @$filesContainer.append @config.render(@files)
        @$filesContainer.find('[data-remove]').on 'click', (event) =>
          event.preventDefault()
          @removeFile $(event.target).data('remove')

        @$filesContainer.show()
      else
        @$filesContainer.append @makeHiddenField(null)
        @$filesContainer.hide()

    makeHiddenField: (value) ->
      $input = $('<input type="hidden">')
      $input.attr 'name', @options.field_name
      $input.val value
      $input

      


)

#----

$ ->
  $('.js-dropin_input').dropin()


