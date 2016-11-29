require 'faraday'
module FaradayMiddleware
  class Emarsys < Faraday::Middleware
    require 'faraday_middleware/emarsys/version'
    require 'faraday_middleware/emarsys/constants'

    dependency do
      require 'json'
      require 'escher-keypool'
      require 'faraday_middleware/escher'
    end

    def initialize(app, credential_scope:, key_id:)
      super(app)

      @signer = ::FaradayMiddleware::Escher::RequestSigner.new(
        @app,
        credential_scope: credential_scope,
        options: self.class::ESCHER_OPTIONS,
        active_key: -> { ::Escher::Keypool.new.get_active_key(key_id) }
      )
    end

    def call(env)
      @signer.call(env)
    end
  end
end
