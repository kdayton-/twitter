require 'helper'

describe Twitter::API do

  before do
    @client = Twitter::Client.new
  end

  describe "#verify_credentials" do
    before do
      stub_get("/1.1/account/verify_credentials.json").
        to_return(:body => fixture("sferik.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "requests the correct resource" do
      @client.verify_credentials
      a_get("/1.1/account/verify_credentials.json").
        should have_been_made
    end
    it "returns the requesting user" do
      user = @client.verify_credentials
      user.should be_a Twitter::User
      user.id.should eq 7505382
    end
  end

  describe "#update_delivery_device" do
    before do
      stub_post("/1.1/account/update_delivery_device.json").
        with(:body => {:device => "sms"}).
        to_return(:body => fixture("sferik.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "requests the correct resource" do
      @client.update_delivery_device("sms")
      a_post("/1.1/account/update_delivery_device.json").
        with(:body => {:device => "sms"}).
        should have_been_made
    end
    it "returns a user" do
      user = @client.update_delivery_device("sms")
      user.should be_a Twitter::User
      user.id.should eq 7505382
    end
  end

  describe "#update_profile" do
    before do
      stub_post("/1.1/account/update_profile.json").
        with(:body => {:url => "http://github.com/sferik/"}).
        to_return(:body => fixture("sferik.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "requests the correct resource" do
      @client.update_profile(:url => "http://github.com/sferik/")
      a_post("/1.1/account/update_profile.json").
        with(:body => {:url => "http://github.com/sferik/"}).
        should have_been_made
    end
    it "returns a user" do
      user = @client.update_profile(:url => "http://github.com/sferik/")
      user.should be_a Twitter::User
      user.id.should eq 7505382
    end
  end

  describe "#update_profile_background_image" do
    before do
      stub_post("/1.1/account/update_profile_background_image.json").
        to_return(:body => fixture("sferik.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "requests the correct resource" do
      @client.update_profile_background_image(fixture("we_concept_bg2.png"))
      a_post("/1.1/account/update_profile_background_image.json").
        should have_been_made
    end
    it "returns a user" do
      user = @client.update_profile_background_image(fixture("we_concept_bg2.png"))
      user.should be_a Twitter::User
      user.id.should eq 7505382
    end
  end

  describe "#update_profile_colors" do
    before do
      stub_post("/1.1/account/update_profile_colors.json").
        with(:body => {:profile_background_color => "000000"}).
        to_return(:body => fixture("sferik.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "requests the correct resource" do
      @client.update_profile_colors(:profile_background_color => "000000")
      a_post("/1.1/account/update_profile_colors.json").
        with(:body => {:profile_background_color => "000000"}).
        should have_been_made
    end
    it "returns a user" do
      user = @client.update_profile_colors(:profile_background_color => "000000")
      user.should be_a Twitter::User
      user.id.should eq 7505382
    end
  end

  describe "#update_profile_image" do
    before do
      stub_post("/1.1/account/update_profile_image.json").
        to_return(:body => fixture("sferik.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "requests the correct resource" do
      @client.update_profile_image(fixture("me.jpeg"))
      a_post("/1.1/account/update_profile_image.json").
        should have_been_made
    end
    it "returns a user" do
      user = @client.update_profile_image(fixture("me.jpeg"))
      user.should be_a Twitter::User
      user.id.should eq 7505382
    end
  end

  describe "#update_profile_banner" do
    before do
      stub_post("/1/account/update_profile_banner.json").
        to_return(:body => fixture("sferik.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "requests the correct resource" do
      @client.update_profile_banner(fixture("me.jpeg"))
      a_post("/1/account/update_profile_banner.json").
        should have_been_made
    end
    it "returns a user" do
      user = @client.update_profile_banner(fixture("me.jpeg"))
      user.should be_a Twitter::User
      user.id.should eq 7505382
    end
  end

  describe "#settings" do
    before do
      stub_get("/1.1/account/settings.json").
        to_return(:body => fixture("settings.json"), :headers => {:content_type => "application/json; charset=utf-8"})
      stub_post("/1.1/account/settings.json").
        with(:body => {:trend_location_woeid => "23424803"}).
        to_return(:body => fixture("settings.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "requests the correct resource on GET" do
      @client.settings
      a_get("/1.1/account/settings.json").
        should have_been_made
    end
    it "returns settings" do
      settings = @client.settings
      settings.should be_a Twitter::Settings
      settings.language.should eq 'en'
    end
    it "requests the correct resource on POST" do
      @client.settings(:trend_location_woeid => "23424803")
      a_post("/1.1/account/settings.json").
        with(:body => {:trend_location_woeid => "23424803"}).
        should have_been_made
    end
    it "returns settings" do
      settings = @client.settings(:trend_location_woeid => "23424803")
      settings.should be_a Twitter::Settings
      settings.language.should eq 'en'
    end
  end

end
