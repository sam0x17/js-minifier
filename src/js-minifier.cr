require "duktape"
require "./uglify"

module JsMinifier
  def self.minify(source : String)
    source = source.gsub("\"", "\\\"")
    source = source.gsub("\n", "\\n")
    ctx = Duktape::Sandbox.new
    src = UGLIFY_JS + "\n" + UGLIFY_DEFAULT_OPTIONS + "\n"
    src += "var res = minify(\"#{source}\");\n"
    src += "print(res.error);\n"
    src += "print(res.code);\n"
    ctx.eval!(src)
  end
end

JsMinifier.minify("test();")
