require 'rails_helper'

RSpec.describe "box_prodcts/show", type: :view do
  before(:each) do
    @box_prodct = assign(:box_prodct, BoxProdct.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
