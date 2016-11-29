$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'faraday_middleware/emarsys'


ENV['KEY_POOL']= JSON.dump(
  [
    {
      "keyId" => "example_v1",
      "secret" => "sickrat",
      "acceptOnly" => 0
    }
  ]
)

ENV['EXAMPLE_KEYID']= "example"
