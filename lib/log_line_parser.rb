class LogLineParser
  attr_reader :line

  def initialize(line)
    @line = line
  end

  def call
    PageView.new(*line.split(/\s+/))
  end
end

