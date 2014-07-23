$ ->
  # $('.js-s3_file_field').S3FileField
  #   remove_completed_progress_bar: false
  #   #progress_bar_target: 
  #   done: (e, data) -> 
  #     alert 'Uploaded ' + content.filename + ' to ' + data.result.url
  #     console.log(data.result.url)

  #  $('.js-s3_file_field').bind 's3_upload_failed', (e, content) ->
  #     alert content.filename + ' failed to upload'

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
      progress = parseInt(data.loaded / data.total * 100, 10)
      $meter.css(width: "#{progress}%")