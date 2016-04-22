require 'rails_helper'

RSpec.describe "box_prodcts/index", type: :view do
  before(:each) do
    assign(:box_prodcts, [
      BoxProdct.create!(),
      BoxProdct.create!()
    ])
  end

  it "renders a list of box_prodcts" do
    render
  end
end
