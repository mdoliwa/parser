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
    puts pages
      .sort_by{|page, ips| -ips.size}
      .map{|page, ips| "#{page} #{ips.size} unique views"}
  end
end

