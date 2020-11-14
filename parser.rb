#!/usr/bin/env ruby

require './lib/log_parser'

analyzers = [PageViewsAnalyzer.new, UniquePageViewsAnalyzer.new]

LogParser.new(ARGV[0], analyzers: analyzers).print_report

