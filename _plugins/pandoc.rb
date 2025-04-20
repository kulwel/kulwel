class Jekyll::Converters::Markdown::Pandoc
  def initialize(_config)
    require 'pandoc-ruby'
    return unless ENV['CF_PAGES']

    puts 'Downloading Pandoc binaries...'
    unless system('curl -L -o _vendor/pandoc.tar.gz "https://github.com/jgm/pandoc/releases/download/3.6.4/pandoc-3.6.4-linux-amd64.tar.gz"')
      raise 'Download failed! Aborting.'
    end

    puts 'success'

    puts 'Extracting tarball...'
    unless system('tar xvzf _vendor/pandoc.tar.gz --strip-components 1 -C _vendor/pandoc/')
      raise 'Extraction failed! Aborting.'
    end

    puts 'success'

    pandoc_bin = File.expand_path('./_vendor/pandoc/bin/pandoc')
    PandocRuby.pandoc_path = pandoc_bin
    puts "Using custom Pandoc binary: #{pandoc_bin}"
  end

  def convert(content)
    html = PandocRuby.new(content, from: 'markdown-smart+mark-subscript+hard_line_breaks+lists_without_preceding_blankline').to_html
    html
      .gsub(/\u{302E}/, '<span class="tone" data-tone="1"><span class="tone-mark">\\0</span></span>')
      .gsub(/\u{302F}/, '<span class="tone" data-tone="2"><span class="tone-mark">\\0</span></span>')
  end
end
