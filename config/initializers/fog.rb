CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => ENV['AWS_KEY'],       # required
    :aws_secret_access_key  => ENV['AWS_SECRET'],       # required
  }
  config.fog_directory  = ENV['AWS_BUCKET']                     # required
  config.fog_public     = false                                   # optional, defaults to true
end