class Implementation_logic
  attr_reader :tmp

  def initialize (tmp)
    @tmp = tmp
  end
  def implement(temperature)
    @temperature = temperature
    if @tmp > 0
      if @temperature > @tmp / 2
        return [-2/@tmp * (@temperature - @tmp), 0].max
      else
        return [ [2/@tmp * @temperature, 1].min , 0 ].max
      end
    else
      if @temperature < @tmp / 2
        return [-2/@tmp * (@temperature - @tmp), 0].max
      else
        return [ [2/@tmp * @temperature, 1].min , 0].max
      end
    end
  end

end
