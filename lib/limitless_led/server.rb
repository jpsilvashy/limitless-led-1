#!/usr/bin/ruby

require 'eventmachine'

require 'date'
require 'rainbow'
require 'color'

module LimitlessLed
  class Server < EM::Connection
    include LimitlessLed::Logger

    def initialize(host: 'localhost', port: 8899)
      @bridge = LimitlessLed::Bridge.new(host: host, port: port)
    end

    # This method dispatches the raw command in bytes to the proper method used
    # to run commands for the led the first byte in the command code tells the
    # real led which command to expect, most commands are 3 bytes long total
    # and always end with 0x55
    #
    # Usage:
    #
    #   # Default
    #   receive_data "\x40\xff\x55"
    #
    # Options:
    #
    # +input+::  bytes used to run the commands
    #
    def receive_data(input)
      command = input.bytes

      case command.first
      when 64
        log_color command[1]
      when 65..77
        raise LimitlessLed::CommandNotImplemented
      else
        raise LimitlessLed::UnknownCommand
      end

    end

  end
end
