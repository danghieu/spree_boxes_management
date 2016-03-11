require 'rails_helper'

RSpec.describe "box_images/index", type: :view do
  before(:each) do
    assign(:box_images, [
      BoxImage.create!(),
      BoxImage.create!()
    ])
  end

  it "renders a list of box_images" do
    render
  end
end
