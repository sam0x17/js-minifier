require "baked_file_system"

class Uglify
  extend BakedFileSystem
  bake_folder "../uglify"
end

UGLIFY_ITEMS = [:minify, :utils, :ast, :parse, :transform, :scope, :output, :compress, :propmangle]
UGLIFY_JS = UGLIFY_ITEMS.map { |item| Uglify.get("#{item}.js").gets_to_end }.join("\n")
