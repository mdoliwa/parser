require 'log_parser'

describe UniquePageViewsAnalyzer do
  describe '#print_report' do
    it 'outputs pages ordered by descending number of unique visits' do
      analyzer = UniquePageViewsAnalyzer.new

      page_views = [
        ['pricing', '3.3.3.3'],
        ['pricing', '2.2.2.2'],
        ['help', '4.4.4.4'],
        ['help', '4.4.4.4'],
        ['help', '4.4.4.4'],
        ['about', '1.1.1.1'],
        ['about', '2.2.2.2'],
        ['about', '3.3.3.3'],
      ]

      page_views
        .map{|page, ip| PageView.new(page, ip)}
        .each{|page_view| analyzer.register_page_view(page_view)}

      expect(analyzer.print_report).to eq ["about 3", "pricing 2", "help 1"]
    end
  end
end

