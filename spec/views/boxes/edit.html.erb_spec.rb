require 'rails_helper'

RSpec.describe "boxes/edit", type: :view do
  before(:each) do
    @box = assign(:box, Box.create!())
  end

  it "renders the edit box form" do
    render

    assert_select "form[action=?][method=?]", box_path(@box), "post" do
    end
  end
end
