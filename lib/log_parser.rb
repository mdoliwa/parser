require 'log_line_parser'
require 'page_view'
require 'analyzers/page_views_analyzer'
require 'analyzers/unique_page_views_analyzer'

class LogParser
  attr_reader :path, :analyzers

  def initialize(path, analyzers: [] )
    @path = path
    @analyzers = analyzers
  end

  def call
    File.readlines(path).each do |line|
      page_view = LogLineParser.new(line).call

      analyzers.each{ |analyzer| analyzer.register_page_view(page_view) }
    end

    analyzers.each(&:print_report)
  end
end

