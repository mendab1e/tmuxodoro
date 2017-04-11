# Tmuxodoro [![Build Status](https://travis-ci.org/mendab1e/tmuxodoro.svg?branch=master)](https://travis-ci.org/mendab1e/tmuxodoro)

**Tmuxodoro** is a minimalistic pomodoro timer designed for tmux.

It can display how many pomodoros remain

<img width="333" alt="screen shot 2017-04-12 at 01 55 05" src="https://cloud.githubusercontent.com/assets/854386/24934268/3875a202-1f23-11e7-9d1f-ed4659727809.png">

How much time remains until the end of a pomodoro

<img width="318" alt="screen shot 2017-04-12 at 01 55 40" src="https://cloud.githubusercontent.com/assets/854386/24934306/778fcf94-1f23-11e7-8c04-23d3acda1041.png">

And how much time remains for a rest

<img width="326" alt="screen shot 2017-04-12 at 01 56 04" src="https://cloud.githubusercontent.com/assets/854386/24934341/bb4714a4-1f23-11e7-9bed-9e162a816715.png">

tmuxodoro doesn't have any stupid notifications or other distraction sounds.



## Installation

Check that you have Ruby >= 2.0 installed, then install tmuxodoro:

    $ gem install tmuxodoro

## Usage

You can run tmuxodoro with default configurations (8 tomatoes, 25 minutes per tomato and 5 minutes for a rest):

	$ tmuxodoro

Or you can set configurations with ENV variables:

	$ env TOMATOES=8 TOMATO_TIME=25 REST_TIME=5 tmuxodoro

Actually tmuxodoro is a pomodoro timer with HTTP interface, so you need to configure tmux to make requests via curl and display output to a statusbar.
Add the following line to `~/.tmux.conf`:

	set -g status-left ' #(curl localhost:3080) '

You can select another port with `ENV['PORT']`, don't forget to change requests in this case.

To start a new pomodoro you need to send the following request:

	$ curl localhost:3080/start

Also you can start it from tmux itself. For example, I've bind it to `prefix + p` (p is mnemonic to pomodoro). Add the following line to `~/.tmux.conf`:

	bind p run-shell "curl localhost:3080/start"

To reset pomodoros you need to send the following request:

	$ curl localhost:3080/restart

Similarly to the previous command, you can bind it to an any key and run from tmux.

Don't forget ro reload tmux config or restart tmux.

## Contributing

Bug reports and pull requests are welcome on GitHub at

https://github.com/mendab1e/tmuxodoro.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
