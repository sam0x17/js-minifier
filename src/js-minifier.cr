#require "duktape/runtime"
require "duktape"
require "./uglify"
require "./syntax_error"

module JsMinifier
  def self.initialize_context
    ctx = Duktape::Sandbox.new
    ctx.eval!(UGLIFY_JS)
    ctx
  end
  @@ctx : Duktape::Sandbox = initialize_context

  def self.minify!(source : String, path : String?, options : JSON::Any?)
    source = source.gsub("\"", "\\\"")
    source = source.gsub("\n", "\\n")
    if options
      options = options.to_json.gsub("'", "\\'")
      puts "var res = minify(\"#{source}\", JSON.stringify('#{options}'));"
      @@ctx.eval!("var res = minify(\"#{source}\", JSON.stringify('#{options}'));")
    else
      @@ctx.eval!("var res = minify(\"#{source}\");")
    end
    @@ctx.eval!("JSON.stringify(res.error)")
    error = @@ctx.get_string(-1)
    @@ctx.eval!("res.code")
    minified = @@ctx.get_string(-1)
    if error
      error = SyntaxError.new(error)
      error.path = path if path
      raise error
    end
    minified
  end

  def self.minify!(source : String, options : JSON::Any?)
    minify!(source, nil, options)
  end

  def self.minify!(source : String)
    minify!(source, nil, nil)
  end
end
