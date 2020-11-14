require 'log_parser'

describe LogParser do
  describe '#call' do
    context 'with page views analayzer' do
      it 'prints most page views report' do
        log_path = 'spec/files/webserver.log'

        expected_output = <<~EOF
        /about/1 4 visits
        /home 3 visits
        /contact 2 visits
        EOF

        parser = LogParser.new(log_path, analyzers: [PageViewsAnalyzer.new])

        expect { parser.call }.to output(expected_output).to_stdout
      end
    end

    context 'with unique page views analyzer' do
      it 'prints unique page views report' do
        log_path = 'spec/files/webserver.log'

        expected_output = <<~EOF
          /home 3 unique views
          /contact 2 unique views
          /about/1 1 unique views
        EOF

        parser = LogParser.new(log_path, analyzers: [UniquePageViewsAnalyzer.new])

        expect { parser.call }.to output(expected_output).to_stdout
      end
    end
  end
end
