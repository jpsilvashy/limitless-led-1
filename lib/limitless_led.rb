#!/usr/bin/ruby
require "limitless_led/version"

require "limitless_led/logger"
require "limitless_led/bridge"
require "limitless_led/server"

module LimitlessLed
  class CommandNotImplemented < StandardError; end
  class UnknownCommand < StandardError; end
end
