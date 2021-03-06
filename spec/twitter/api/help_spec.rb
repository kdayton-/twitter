require 'helper'

describe Twitter::API do

  before do
    @client = Twitter::Client.new
  end

  describe "#configuration" do
    before do
      stub_get("/1.1/help/configuration.json").
        to_return(:body => fixture("configuration.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "requests the correct resource" do
      @client.configuration
      a_get("/1.1/help/configuration.json").
        should have_been_made
    end
    it "returns Twitter's current configuration" do
      configuration = @client.configuration
      configuration.should be_a Twitter::Configuration
      configuration.characters_reserved_per_media.should eq 20
    end
  end

  describe "#languages" do
    before do
      stub_get("/1.1/help/languages.json").
        to_return(:body => fixture("languages.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "requests the correct resource" do
      @client.languages
      a_get("/1.1/help/languages.json").
        should have_been_made
    end
    it "returns the list of languages supported by Twitter" do
      languages = @client.languages
      languages.should be_an Array
      languages.first.should be_a Twitter::Language
      languages.first.name.should eq "Portuguese"
    end
  end

  describe "#privacy" do
    before do
      stub_get("/1.1/help/privacy.json").
        to_return(:body => fixture("privacy.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "requests the correct resource" do
      @client.privacy
      a_get("/1.1/help/privacy.json").
        should have_been_made
    end
    it "returns Twitter's Privacy Policy" do
      privacy = @client.privacy
      privacy.split.first.should eq "Twitter"
    end
  end

  describe "#tos" do
    before do
      stub_get("/1.1/help/tos.json").
        to_return(:body => fixture("tos.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "requests the correct resource" do
      @client.tos
      a_get("/1.1/help/tos.json").
        should have_been_made
    end
    it "returns Twitter's Terms of Service" do
      tos = @client.tos
      tos.split.first.should eq "Terms"
    end
  end

end
