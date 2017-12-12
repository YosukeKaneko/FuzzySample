class Fuzzy_logic
  def initialize (thr_1, thr_2, up_or_down)
    @thr_1 = thr_1
    @thr_2 = thr_2
    @up_or_down = up_or_down
  end

  def membership_func (variable)
    @variable = variable
    case @up_or_down
    when "up"
      if @variable < @thr_1
        return 0
      else
        return [ (@variable - @thr_1)/(@thr_2 - @thr_1), 1].min
      end
    when "down"
      if @variable > @thr_1
        return 0
      else
        return [ (@variable - @thr_1)/(@thr_2 - @thr_1), 1].min
      end
    end
  end

  def get_thr_1()
    return @thr_1
  end
  def get_thr_2()
    return @thr_2
  end
  def get_up_or_down()
    return @up_or_down
  end
end
