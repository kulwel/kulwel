class Jekyll::Converters::Markdown::Pandoc
    def initialize(config)
        require "pandoc-ruby"
        if ENV["CF_PAGES"]
            system("wget -O _vendor/pandoc.tar.gz \"https://github.com/jgm/pandoc/releases/download/3.6.4/pandoc-3.6.4-linux-amd64.tar.gz\" && tar xvzf _vendor/pandoc.tar.gz --strip-components 2 -C _vendor/pandoc/")
            pandoc_bin = File.expand_path("./_vendor/pandoc/bin/pandoc")
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