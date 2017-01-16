require 'rails_helper'

RSpec.describe "tests/new", type: :view do
  before(:each) do
    assign(:test, Test.new(
      :title => "MyString",
      :txt => "MyText"
    ))
  end

  it "renders new test form" do
    render

    assert_select "form[action=?][method=?]", tests_path, "post" do

      assert_select "input#test_title[name=?]", "test[title]"

      assert_select "textarea#test_txt[name=?]", "test[txt]"
    end
  end
end
