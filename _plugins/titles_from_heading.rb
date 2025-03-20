module TitlesFromHeadings
  class Generator < Jekyll::Generator
    attr_accessor :site

    safe true
    priority :lowest

    def generate(site)
      @markdown_converter ||= site.find_converter_instance(Jekyll::Converters::Markdown)
      documents = site.pages + site.docs_to_write

      documents.each do |document|
        next unless @markdown_converter.matches(document.extname)
        next if document.is_a?(Jekyll::StaticFile)

        if match = document.content.match(/\A\s*#\s+(.+)\n([\s\S]*)/)
          document.data["title"], document.content = match.captures
        else
          next
        end

        if match = document.content.match(/\A\s*##\s+(.+)\n([\s\S]*)/)
          document.data["subtitle"], document.content = match.captures
        end
      end
    end
  end
end
