class Jekyll::Converters::Markdown::Pandoc
    def initialize(config)
        require "pandoc-ruby"
        if ENV["CF_PAGES"]
            puts "Downloading Pandoc binaries..."
            if system("curl -L -o _vendor/pandoc.tar.gz \"https://github.com/jgm/pandoc/releases/download/3.6.4/pandoc-3.6.4-linux-amd64.tar.gz\"")
                puts "success"
            else 
                raise "Download failed! Aborting."
            end
            puts "Extracting tarball..."
            if system("tar xvzf _vendor/pandoc.tar.gz --strip-components 2 -C _vendor/pandoc/")
                puts "success"
            else
                raise "Extraction failed! Aborting."
            end
            pandoc_bin = File.expand_path("./_vendor/pandoc/bin/pandoc")
            PandocRuby.pandoc_path = pandoc_bin
            puts "Using custom Pandoc binary: #{pandoc_bin}"
        end
    end

    def convert(content)
        content = content.gsub(/\u{302E}/, "<span class=\"tone\" data-tone=\"1\"><span class=\"tone-mark\">\\0</span></span>")
        content = content.gsub(/\u{302F}/, "<span class=\"tone\" data-tone=\"2\"><span class=\"tone-mark\">\\0</span></span>")
        PandocRuby.new(content, from: "markdown+mark-subscript+hard_line_breaks+lists_without_preceding_blankline").to_html
    end
end