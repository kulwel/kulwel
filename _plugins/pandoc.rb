class Jekyll::Converters::Markdown::Pandoc
    def initialize(config)
        require "pandoc-ruby"
        if ENV["CF_PAGES"]
            pandoc_bin = File.expand_path("./_vendor/pandoc")
            PandocRuby.pandoc_path = pandoc_bin
            puts "Using bundled Pandoc binary: #{pandoc_bin}"
        end
    end

    def convert(content)
        content = content.gsub(/\u{302E}/, "<span class=\"tone\" data-tone=\"1\"><span class=\"tone-mark\">\\0</span></span>")
        content = content.gsub(/\u{302F}/, "<span class=\"tone\" data-tone=\"2\"><span class=\"tone-mark\">\\0</span></span>")
        PandocRuby.new(content, from: "markdown+mark-subscript+hard_line_breaks+lists_without_preceding_blankline").to_html
    end
end