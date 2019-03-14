Recaptcha.configure do |config|
  config.site_key  = ENV['RECAPTCHA_ASK_ANSWER_PUBLIC_KEY']
  config.secret_key = ENV['RECAPTCHA_ASK_ANSWER_PRIVATE_KEY']
end