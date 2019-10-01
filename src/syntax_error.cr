require "json"

module JsMinifier
  class SyntaxError < Exception
    property error_message : String
    property line : Int32
    property col : Int32
    property pos : Int32
    property path : String?

    def initialize(@error_message, @line, @col, @pos, @path)
    end

    def initialize(json_dump : String)
      data = JSON.parse(json_dump)
      @error_message = data["message"].as_s
      @line = data["line"]? ? data["line"].as_i : 0
      @col = data["col"]? ? data["col"].as_i : 0
      @pos = data["pos"]? ? data["pos"].as_i : 0
    end

    def message
      "#{error_message}, #{@path ? "file: #{path}, " : ""}line: #{@line}, col: #{col}, pos: #{pos}"
    end
  end
end
