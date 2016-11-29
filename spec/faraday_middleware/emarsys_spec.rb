require 'spec_helper'

describe FaradayMiddleware::Emarsys do
  it 'has a version number' do
    expect(FaradayMiddleware::Emarsys::VERSION).not_to be nil
  end

  let(:received_env) { {} }

  let(:faraday_stub) do
    re = received_env
    lambda do |stubs|
      stubs.get('/cica') { |e| re.merge!(e); rack_response }
    end
  end

  let(:rack_response) { [200, {}, 'OK'] }

  let(:credential_scope) { 'a/b/c' }
  let(:key_id) { 'example' }
  let(:options) { { credential_scope: credential_scope, key_id: key_id } }

  let(:faraday) do
    Faraday.new do |b|
      b.use described_class, options
      b.adapter(:test, &faraday_stub)
    end
  end

  let(:env) do
    {

    }
  end

  describe '#call' do
    subject { faraday.get('https://www.example.org/cica') }

    it 'should return the response' do
      expect(subject.status).to eq 200
      expect(subject.body).to eq 'OK'
    end

    describe 'escher auth with emarsys conventions' do
      it 'should include the EMS headers' do
        subject

        headers = received_env[:request_headers].keys.map(&:downcase)
        ['x-ems-auth', 'x-ems-date', 'host'].each do |header|
          expect(headers).to include(header)
        end
      end

      it 'should sign the request with escher' do
        subject

        escher = ::Escher::Auth.new(credential_scope, described_class::ESCHER_OPTIONS)

        url_path = received_env[:url].path
        url_path = '/' if url_path.empty?

        escher_hash_env = {
          uri: url_path,
          method: received_env[:method].to_s.upcase,
          headers: received_env[:request_headers].map { |k, v| [k, v] }
        }

        escher_hash_env[:body] = received_env[:body] if received_env[:body]
        escher.authenticate(escher_hash_env, ::Escher::Keypool.new.get_key_db)
      end
    end
  end
end
