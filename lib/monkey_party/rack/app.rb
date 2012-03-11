require 'rack/request'
require 'rack/response'
require 'json'

module MonkeyParty
  module Rack
    class App
      def call(env)
        @env = env
        status, body = nil, nil

        if request.params["subscriber"]
          results = MonkeyParty.list.create_subscribers([subscriber])
          if results[0].valid?
            status = 201
          else
            status = 421
          end
          body = results[0].to_h.to_json
        else
          status = 412
        end
        ::Rack::Response.new(body || [], status).finish
      end

      protected
      def subscriber
        @subscriber = MonkeyParty::Subscriber.new(
          request.params["subscriber"].delete("email"),
          request.params["subscriber"])
      end

      def request
        @request = ::Rack::Request.new(@env)
      end
    end
  end
end
