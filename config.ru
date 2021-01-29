# frozen_string_literal: true

require_relative 'lib/params_formatter'

require_relative 'middleware/dispatcher'
require_relative 'middleware/app_logger'
require_relative 'app'

use Dispathcer
use AppLogger, logdev: File.expand_path('log/app.log', __dir__)
run App.new
