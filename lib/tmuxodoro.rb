require 'tmuxodoro/version'
require 'tmuxodoro/pomodoro'
require 'webrick'

module Tmuxodoro
  class << self
    def run(port, args = {})
      pomodoro = Pomodoro.new(args)
      server = WEBrick::HTTPServer.new(Port: port)

      server.mount_proc('/') do |req, resp|
        resp['Content-Type'] = 'text/plain'
        resp.body = pomodoro.status
      end

      server.mount_proc('/start') do |req, resp|
        pomodoro.start
        resp['Content-Type'] = 'text/plain'
        resp.body = "New tomato has been started, it ends at #{pomodoro.stop_at}.\n"
      end

      server.mount_proc('/restart') do |req, resp|
        pomodoro = Pomodoro.new(args)
        resp['Content-Type'] = 'text/plain'
        resp.body = "Tomatoes have been reset\n"
      end

      server.start
    end
  end
end
