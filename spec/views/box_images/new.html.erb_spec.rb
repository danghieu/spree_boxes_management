require 'rails_helper'

RSpec.describe "box_images/new", type: :view do
  before(:each) do
    assign(:box_image, BoxImage.new())
  end

  it "renders new box_image form" do
    render

    assert_select "form[action=?][method=?]", box_images_path, "post" do
    end
  end
end
