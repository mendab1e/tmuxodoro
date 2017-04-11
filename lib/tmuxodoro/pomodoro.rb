class Pomodoro
  MINUTE = 60

  attr_reader :tomatos, :tomato_time, :rest_time, :stop_at

  def initialize(tomatos: 8, tomato_time: 55 * MINUTE, rest_time: 5 * MINUTE)
    @tomatos = tomatos
    @tomato_time = tomato_time
    @rest_time = rest_time
  end

  def status
    if is_active?
      if work_time?
        "work: #{remaining_work_time} min\n"
      else
        "rest: #{remaining_rest_time} min\n"
      end
    else
      "🍅 #{tomatos}\n"
    end
  end

  def start
    @tomatos -= 1
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
end
