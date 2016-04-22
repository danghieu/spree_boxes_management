require "rails_helper"

RSpec.describe BoxImagesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/box_images").to route_to("box_images#index")
    end

    it "routes to #new" do
      expect(:get => "/box_images/new").to route_to("box_images#new")
    end

    it "routes to #show" do
      expect(:get => "/box_images/1").to route_to("box_images#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/box_images/1/edit").to route_to("box_images#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/box_images").to route_to("box_images#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/box_images/1").to route_to("box_images#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/box_images/1").to route_to("box_images#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/box_images/1").to route_to("box_images#destroy", :id => "1")
    end

  end
end
