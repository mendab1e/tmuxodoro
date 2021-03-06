class Pomodoro
  MINUTE = 60

  attr_reader :tomatoes, :tomato_time, :rest_time, :stop_at, :initial_tomatoes

  def initialize(tomatoes: nil, tomato_time: nil, rest_time: nil)
    @tomatoes = @initial_tomatoes = tomatoes || 8
    @tomato_time = tomato_time || 25 * MINUTE
    @rest_time = rest_time || 5 * MINUTE
  end

  def status
    if is_active?
      if work_time?
        "work: #{remaining_work_time} min\n"
      else
        "rest: #{remaining_rest_time} min\n"
      end
    else
      remain_tomatoes_status
    end
  end

  def start
    @tomatoes = initial_tomatoes if tomatoes == 0
    @tomatoes -= 1
    @stop_at = Time.now + tomato_time
  end

  private

  def is_active?
    stop_at && Time.now < stop_at + rest_time
  end

  def work_time?
    Time.now < stop_at
  end

  def remaining_work_time
    return unless stop_at
    ((stop_at - Time.now) / MINUTE).ceil
  end

  def remaining_rest_time
    return unless stop_at
    ((stop_at + rest_time - Time.now) / MINUTE).ceil
  end

  def remain_tomatoes_status
    tomatoes > 0 ? "🍅  #{tomatoes}\n" : "work is done\n"
  end
end
