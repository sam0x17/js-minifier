require "duktape"
require "./uglify"

module JsMinifier
  private def self.create_uglify_context
    ctx = Duktape::Sandbox.new
    ctx.eval!(UGLIFY_JS)
    ctx
  end

  @@ctx : Duktape::Sandbox = create_uglify_context

  def self.minify(source : String)
  end
end

JsMinifier.minify("test")
