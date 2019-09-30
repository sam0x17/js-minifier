require "./spec_helper"

describe JsMinifier do
  it "catches syntax errors" do
    expect_raises(JsMinifier::SyntaxError) { JsMinifier.minify!("function function") }
    expect_raises(JsMinifier::SyntaxError) { JsMinifier.minify!("var var") }
  end

  it "minifies variable declarations" do
    JsMinifier.minify!("var blah = true;").should eq "var blah=!0;"
  end

  it "minifies functions" do
    JsMinifier.minify!("function foo() { return true; }").should eq "function foo(){return!0}"
  end

  it "minifies multiline blocks" do
    src = <<-JS
      var something = 22;
      function foo() {
        return "bar";
      }
    JS
    JsMinifier.minify!(src).should eq "var something=22;function foo(){return\"bar\"}"
  end
end
