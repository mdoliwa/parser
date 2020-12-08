require_relative 'log_line_parser'
require_relative 'page_view'
require_relative 'analyzers/page_views_analyzer'
require_relative 'analyzers/unique_page_views_analyzer'
require_relative 'analyzers/average_page_views_analyzer'

class LogParser
  attr_reader :path, :analyzers

  def initialize(path, analyzers: [])
    @path = path
    @analyzers = analyzers
  end

  def print_report
    File.readlines(path).each do |line|
      page_view = LogLineParser.new(line).call

      analyzers.each{ |analyzer| analyzer.register_page_view(page_view) }
    end

    analyzers.each(&:print_report)
  end
end

