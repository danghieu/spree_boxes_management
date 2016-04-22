require 'rails_helper'

RSpec.describe "box_images/show", type: :view do
  before(:each) do
    @box_image = assign(:box_image, BoxImage.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
