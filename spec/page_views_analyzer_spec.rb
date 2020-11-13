require 'log_parser'

describe PageViewsAnalyzer do
  describe '#print_report' do
    it 'outputs pages ordered by descending number of views' do
      analyzer = PageViewsAnalyzer.new

      page_views = [
        ['about', '1.1.1.1'],
        ['about', '2.2.2.2'],
        ['pricing', '3.3.3.3'],
        ['help', '4.4.4.4'],
        ['help', '4.4.4.4'],
        ['help', '4.4.4.4'],
        ['help', '5.5.5.5']
      ]

      page_views
        .map{|page, ip| PageView.new(page, ip)}
        .each{|page_view| analyzer.register_page_view(page_view)}

      expect(analyzer.print_report).to eq ["help 4", "about 2", "pricing 1"]
    end
  end
end
