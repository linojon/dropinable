# $ ->
#   $('.js-s3_file_field').S3FileField
#     remove_completed_progress_bar: false
#     #progress_bar_target: 
#     done: (e, data) -> 
#       alert 'Uploaded ' + content.filename + ' to ' + data.result.url
#       console.log(data.result.url)

#    $('.js-s3_file_field').bind 's3_upload_failed', (e, content) ->
#       alert content.filename + ' failed to upload'

ready = ->
  $('.js-s3_file_field').each ->
    id = $(this).attr('id')
    $this = -> $("##{id}")
    $uploader = $(this).siblings('.dropin_uploader')
    $thumb    = $uploader.find('.dropin_thumb')
    $progress = $uploader.find('.dropin_progress')
    $(this).S3FileField
      add: (e, data) ->
        load_thumb(e, $thumb)
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
        # $meter.css(width: "#{progress}%")
        $progress.progressCircle
          nPercent: progress
          circleSize: 40

  load_thumb = (event, ele) ->
    canvas = ele.find('canvas')[0] # jquery to pure Canvas element
    ctx = canvas.getContext('2d')

    reader = new FileReader()
    reader.onload = (event) ->
      img = new Image()
      img.onload = ->
        if img.height > img.width
          w = 75 * img.width / img.height
          h = 75
        else
          w = 75
          h = 75 * img.height / img.width
        canvas.width = 75
        canvas.height = 75
        ctx.drawImage( img, 0, 0, w, h )
      #
      img.src = event.target.result
    #
    reader.readAsDataURL( event.currentTarget.files[0] )
  #


$(document).ready(ready)
$(document).on('page:load', ready)
