require 'faraday_middleware/emarsys'
class FaradayMiddleware::Emarsys
  CONTENT_TYPE = 'Content-Type'.freeze
  DEFAULT_MIME_TYPE = 'application/json'.freeze
  STREAM_MIME_TYPE = 'application/stream+json'.freeze

  ESCHER_OPTIONS = {
    algo_prefix: 'EMS',
    vendor_key: 'EMS',
    auth_header_name: 'X-Ems-Auth',
    date_header_name: 'X-Ems-Date'
  }.each do |k, v|
    k.freeze
    v.freeze
  end.freeze
end
