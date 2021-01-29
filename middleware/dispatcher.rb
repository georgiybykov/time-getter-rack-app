# frozen_string_literal: true

class Dispathcer
  def initialize(app)
    @app = app
  end

  def call(env)
    path = request_path(env["PATH_INFO"])

    path.eql?('time') ? app.call(env) : not_found
  end

  private

  attr_reader :app

  def request_path(path_info)
    path_info.downcase.gsub(/\//, '')
  end

  def not_found
    [
      404,
      { "Content-Type" => "text/plain" },
      ['Unknown path | Error 404']
    ]
  end
end
