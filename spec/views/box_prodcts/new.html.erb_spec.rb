require 'rails_helper'

RSpec.describe "box_prodcts/new", type: :view do
  before(:each) do
    assign(:box_prodct, BoxProdct.new())
  end

  it "renders new box_prodct form" do
    render

    assert_select "form[action=?][method=?]", box_prodcts_path, "post" do
    end
  end
end
