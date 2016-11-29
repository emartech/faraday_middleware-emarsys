require "faraday_middleware/emarsys"
path = File.join(File.dirname(__FILE__),'..','..','..','VERSION')
FaradayMiddleware::Emarsys::VERSION = File.read(path).chomp
