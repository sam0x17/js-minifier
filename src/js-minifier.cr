require "duktape/runtime"
require "./uglify"

module JsMinifier
  @@ctx = Duktape::Runtime.new { |ctx| ctx.eval!(UGLIFY_JS) }

  def self.minify(source : String)
    source = source.gsub("\"", "\\\"")
    source = source.gsub("\n", "\\n")
    @@ctx.eval("var res = minify(\"#{source}\");\n")
    res = @@ctx.call("res")
  end
end

JsMinifier.minify("test();")
