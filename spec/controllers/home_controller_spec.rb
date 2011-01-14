require 'spec_helper'

describe HomeController do
  before :each do
    controller.should_receive(:authenticate_user!).with(no_args).once.and_return(true) 
  end

  context "GET 'index'" do

    it "should be successful" do
      get :index
      response.should be_success
    end
  end
end
