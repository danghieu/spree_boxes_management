require 'rails_helper'

RSpec.describe "box_prodcts/edit", type: :view do
  before(:each) do
    @box_prodct = assign(:box_prodct, BoxProdct.create!())
  end

  it "renders the edit box_prodct form" do
    render

    assert_select "form[action=?][method=?]", box_prodct_path(@box_prodct), "post" do
    end
  end
end
