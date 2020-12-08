require 'log_parser'

describe AveragePageViewsAnalyzer do
  describe '#print_report' do
    it 'outputs pages ordered by descending number of averagepage views' do
      analyzer = AveragePageViewsAnalyzer.new

      page_views = [
        ['about', '1.1.1.1'],
        ['about', '2.2.2.2'],
        ['help', '4.4.4.4'],
        ['help', '4.4.4.4'],
        ['help', '4.4.4.4'],
        ['help', '5.5.5.5'],
        ['pricing', '1.1.1.1'],
        ['pricing', '3.3.3.3'],
        ['pricing', '3.3.3.3']
      ]

      page_views
        .map{|page, ip| PageView.new(page, ip)}
        .each{|page_view| analyzer.register_page_view(page_view)}

      expected_output = <<~EOF
        about 1 average page views
        pricing 1.5 average page views
        help 2 average page views

      EOF

      expect{analyzer.print_report}.to output(expected_output).to_stdout
    end
  end
end

