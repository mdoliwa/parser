require 'log_parser'

describe LogParser do
  describe '#page_views' do
    it "shows page views" do
      path = "spec/files/webserver.log"

      expected_output = ["/about/1 4", "/home 3", "/contact 2"].join("\n")

      expect(LogParser.new(path).page_views).to eq expected_output
    end
  end

  describe '#unique_page_views' do
    it "shows unique page views" do
      path = "spec/files/webserver.log"

      expected_output = ["/home 3", "/contact 2", "/about/1 1"].join("\n")

      expect(LogParser.new(path).unique_page_views).to eq expected_output
    end
  end
end

