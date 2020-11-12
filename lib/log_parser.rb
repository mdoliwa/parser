class LogParser
  attr_reader :path, :data

  def initialize(path)
    @path = path
    @data = {}
  end

  def prepare_data
    File.readlines(path).each do |line|
      page, ip = line.split(/\s+/)

      data[page] = data[page] ? data[page] << ip : [ip]
    end
  end

  def page_views
    prepare_data if data.empty?

    data.
      sort_by{|page, ips| -ips.length}.
      map{|page, ips| "#{page} #{ips.length}"}.
      join("\n")
  end

  def unique_page_views
    prepare_data if data.empty?

    data.
      sort_by{|page, ips| -ips.uniq.length}.
      map{|page, ips| "#{page} #{ips.uniq.length}"}.
      join("\n")
  end
end

