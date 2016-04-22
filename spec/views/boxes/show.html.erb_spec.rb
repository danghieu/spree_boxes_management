require 'rails_helper'

RSpec.describe "boxes/show", type: :view do
  before(:each) do
    @box = assign(:box, Box.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
