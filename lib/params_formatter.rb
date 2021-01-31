# frozen_string_literal: true

class ParamsFormatter
  TIME_METHODS = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: '%Hh',
    minute: '%Mm',
    second: '%Ss'
  }.freeze

  AVAILABLE_FORMATS = %w[year month day hour minute second]

  attr_reader :errors

  def initialize(params)
    @time_formats = convert_params(params)
    @errors = []

    validate!
  end

  def body
    errors.empty? ? success : failure
  end

  private

  attr_reader :time_formats

  def convert_params(params)
    params['format'].split(',')
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
