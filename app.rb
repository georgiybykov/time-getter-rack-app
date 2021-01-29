# frozen_string_literal: true

class App
  def call(env)
    @formatted_params = ParamsFormatter.new(env["QUERY_STRING"])

    [status, headers, body]
  end

  private

  attr_reader :formatted_params

  def status
    formatted_params.errors.empty? ? 200 : 400
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    formatted_params.body
  end
end
