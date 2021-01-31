# frozen_string_literal: true

class App
  HTTP_STATUS = { ok: 200, bad_request: 400 }.freeze

  def call(env)
    @request = Rack::Request.new(env)
    @formatted_params = ParamsFormatter.new(request.params)

    [status, {}, body]
  end

  private

  attr_reader :request, :formatted_params

  def body
    formatted_params.body
  end

  def status
    formatted_params.errors.empty? ? HTTP_STATUS[:ok] : HTTP_STATUS[:bad_request]
  end
end
