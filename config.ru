# frozen_string_literal: true

require_relative 'middleware/app_logger'
require_relative 'app'

use AppLogger, logdev: File.expand_path('log/app.log', __dir__)
use Rack::ContentType, 'text/plain'
run Rack::URLMap.new "/time" => App.new
