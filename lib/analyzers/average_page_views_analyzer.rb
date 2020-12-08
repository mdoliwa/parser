class AveragePageViewsAnalyzer
  attr_reader :pages

  def initialize
    @pages = {}
  end

  def register_page_view(page_view)
    if pages[page_view.page]
      pages[page_view.page] = {total_page_views: pages[page_view.page][:total_page_views] + 1, unique_ips: pages[page_view.page][:unique_ips] << page_view.ip}
    else
      pages[page_view.page] = {total_page_views: 1, unique_ips: Set[page_view.ip]}
    end
  end

  def print_report
    puts pages
      .map {|page, page_info| [page, page_info[:total_page_views] / page_info[:unique_ips].size.to_f]}.to_h
      .sort_by { |page, average_page_views| average_page_views }
      .map { |page, average_page_views| "#{page} #{average_page_views} average visits" }

  end
end
