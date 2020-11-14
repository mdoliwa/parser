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
    puts pages
      .sort_by{|page, page_views_count| -page_views_count}
      .map{|page, page_views_count| "#{page} #{page_views_count} visits"}
  end
end

