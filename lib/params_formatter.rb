# frozen_string_literal: true

class ParamsFormatter
  TIME_METHODS = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: '%H',
    minute: '%M',
    second: '%S'
  }.freeze

  AVAILABLE_FORMATS = %w[year month day hour minute second]

  attr_reader :errors

  def initialize(query)
    @time_formats = parse(query)
    @errors = []

    validate!
  end

  def body
    errors.empty? ? success : failure
  end

  private

  attr_reader :time_formats

  def parse(query)
    query.split('=')[-1].split('%2C')
  end

  def validate!
    time_formats.map { |format| errors << format unless AVAILABLE_FORMATS.include?(format) }
  end

  def success
    [result_time]
  end

  def failure
    ["Unknown time format: [#{errors.join(', ')}]"]
  end

  def result_time
    Time.now.strftime(split_format)
  end

  def split_format
    time_formats.map { |format| TIME_METHODS[format.to_sym] }.join('-')
  end
end
