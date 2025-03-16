class Jekyll::Converters::Markdown::Pandoc
    def initialize(config)
        require "pandoc-ruby"
    end

    def convert(content)
        if ENV["CF_PAGES"]
            pandoc_bin = File.expand_path("./pandoc")
            PandocRuby.pandoc_path = pandoc_bin
            puts "Using bundled Pandoc binary: #{pandoc_bin}"
        end
        PandocRuby.new(content, from: "markdown+mark-subscript+hard_line_breaks+lists_without_preceding_blankline").to_html
    end
end