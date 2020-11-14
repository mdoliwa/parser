require 'log_parser'

describe LogLineParser do
  describe '#call' do
    it 'extracts page from log line' do
      line = 'about 1.1.1.1'

      expect(LogLineParser.new(line).call.page).to eq 'about'
    end

    it 'extracts ip from log line' do
      line = 'about 1.1.1.1'

      expect(LogLineParser.new(line).call.ip).to eq '1.1.1.1'
    end
  end
end
