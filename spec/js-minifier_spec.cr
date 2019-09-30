require "./spec_helper"

describe JsMinifier do
  it "catches syntax errors" do
    expect_raises(JsMinifier::SyntaxError) { JsMinifier.minify!("function function") }
    expect_raises(JsMinifier::SyntaxError) { JsMinifier.minify!("var var") }
  end
end
