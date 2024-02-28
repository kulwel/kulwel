class Jekyll::Converters::Markdown::Pandoc
    def initialize(config)
        require "pandoc-ruby"
    end
  
    def convert(content)
        PandocRuby.new(content, from: "markdown+mark-subscript+hard_line_breaks+lists_without_preceding_blankline").to_html
    end
  end