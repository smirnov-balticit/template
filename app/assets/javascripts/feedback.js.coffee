isEmail = (email) ->
  email = $.trim(email)
  regex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/
  regex.test email

jQuery ->
  $('form#new_feedback').on 'ajax:beforeSend', ->
    unless isEmail($('#feedback_email').val())
      noty
        text: I18n.t('js.wrong_email')
        type: 'error'
      return false
  $('form#new_feedback').on 'ajax:success', ->
    noty text: I18n.t('js.send_success')
  $('form#new_feedback').on 'ajax:error', ->
    noty
      text: I18n.t('js.send_error')
      type: 'error'
