require 'rails_helper'

RSpec.describe "boxes/index", type: :view do
  before(:each) do
    assign(:boxes, [
      Box.create!(),
      Box.create!()
    ])
  end

  it "renders a list of boxes" do
    render
  end
end
