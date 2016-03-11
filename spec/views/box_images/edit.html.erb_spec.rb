require 'rails_helper'

RSpec.describe "box_images/edit", type: :view do
  before(:each) do
    @box_image = assign(:box_image, BoxImage.create!())
  end

  it "renders the edit box_image form" do
    render

    assert_select "form[action=?][method=?]", box_image_path(@box_image), "post" do
    end
  end
end
