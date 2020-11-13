class LogParser
  attr_reader :path, :data

  def initialize(path, analyzers = [])
    @path = path
  end

  def call
    File.readlines(path).each do |line|
      page_view = LogLineParser.new(line).call

      analyzers.each{ |analyzer| analyzer.register_page_view(page_view) }
    end

    analyzers.each(&:print_report)
  end
end

class PageView < Struct.new(:page, :ip); end

class PageViewsAnalyzer
  attr_reader :pages

  def initialize
    @pages = {}
  end

  def register_page_view(page_view)
    if pages[page_view.page]
      pages[page_view.page] += 1
    else
      pages[page_view.page] = 1
    end
  end

  def print_report
    pages
      .sort_by{|page, page_views_count| -page_views_count}
      .map{|page, page_views_count| "#{page} #{page_views_count} visits"}
  end
end

class UniquePageViewsAnalyzer
  attr_reader :pages

  def initialize
    @pages = {}
  end

  def register_page_view(page_view)
    if pages[page_view.page]
      pages[page_view.page] << page_view.ip
    else
      pages[page_view.page] = Set[page_view.ip]
    end
  end

  def print_report
    pages
      .sort_by{|page, ips| -ips.size}
      .map{|page, ips| "#{page} #{ips.size} unique views"}
  end
end
