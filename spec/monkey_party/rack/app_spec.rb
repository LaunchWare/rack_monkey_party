require 'spec_helper'

#this is really an integration test because it actually hits the mailchimp api
describe MonkeyParty::Rack::App, :vcr do
  include Rack::Test::Methods

  def app
    MonkeyParty::Rack::App.new
  end

  let(:email) { "auser@anexample.com" }

  describe "when a subscriber isn't specified" do
    it "returns a precondition not met" do
      post "/"
      last_response.status.should eql(412)
    end
  end

  describe "when a proper subscriber is posted" do
    it "returns a succcessful response" do
      do_post
      last_response.status.should eql(201)
    end

    it "returns the email in the body" do
      do_post
      last_response.body.should =~ /#{Regexp.escape(email)}/
    end
  end

  describe "when an invalid subscriber is posted" do
    let(:email) { "bademail" }

    it "returns a 412 unprecessable entity" do
      do_post
      last_response.status.should eql(421)
    end

    it "returns the error in the body" do
      do_post
      last_response.body.should =~ /invalid/i
    end
  end

  describe "when a user requests json" do
    it "responds with json" do
      do_post
      last_response.content_type.should eql("application/json")
    end
  end

  describe "when a user requests html" do
    it "responds with html" do
      do_post("html")
      last_response.content_type.should eql("text/html")
    end
  end

  def do_post(format = "json")
    post "/post.#{format}", { "subscriber" => {"email" => email}}
  end
end

