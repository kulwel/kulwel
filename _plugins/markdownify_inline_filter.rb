module Jekyll::MarkdownifyInlineFilter
  include Liquid::StandardFilters

  def markdownify_inline(input)
    markdownify(input).gsub(/<p>([\s\S]*)<\/p>/, "\\1")
  end
end

Liquid::Template.register_filter(Jekyll::MarkdownifyInlineFilter)
