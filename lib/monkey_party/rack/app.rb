require 'rack/request'
require 'rack/response'
require 'json'

module MonkeyParty
  module Rack
    class App
      def call(env)
        @env = env
        body, content_type = nil, nil
        if request.params["subscriber"]
          @results = MonkeyParty.list.create_subscribers([subscriber])
          if results[0].valid?
            @status = 201
          else
            @status = 421
          end
        else
          @status = 412
        end

        if request.path =~ /.json$/
          body = results[0].to_h.to_json
          content_type = "application/json"
        else
          body = html_body
          content_type = "text/html"
        end

        ::Rack::Response.new(body || [], status, {
          "Content-Type" => content_type
        }).finish
      end

      protected
      def status
        @status
      end

      def results
        @results
      end

      def html_body
        body = nil
        if status == 201
          body = "<p>Thank you! You'll hear from us soon!</p>"
        else
          body = "<p>Something Went Wrong!</p>"
          if results && results[0] && results[0].error
            body += "<p>#{results[0].error.message}</p>"

          end
        end

        if request.referrer && request.referrer != ''
          body += "<p><a href=\"#{request.referrer}\">Go Back</a></p>"
        end
      end

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
