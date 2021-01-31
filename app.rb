# frozen_string_literal: true

class App
  def call(env)
    @request = Rack::Request.new(env)
    @formatted_params = ParamsFormatter.new(request.params)

    [status, headers, body]
  end

  private

  attr_reader :request, :formatted_params

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
