class Visualizer
  attr_reader :from_point, :to_point, :pitch, :itr

  def initialize (from_point, to_point, pitch)
    @from_point = from_point
    @to_point = to_point
    @pitch = pitch
    @itr = ((to_point - from_point) / pitch ).ceil.to_i
  end

  def calculatetmp (tmp)
    @itr.times do |i|
      puts "#{from_point + i * pitch}, #{tmp.implement(from_point + i * pitch)}"
    end
  end

  def calculatelogic (membership)
    @itr.times do |i|
      puts "#{from_point + i * pitch}, #{membership.membership_func(from_point + i * pitch)}"
    end
  end

  def calculateresult
    @itr.times do |i|
      puts "#{from_point + i * pitch}, #{calculateresult((from_point + i * pitch), lower_temp, lower_temp, raise_temp, raise_temp, fit)}"
    end
  end
end

# example
# visualizer = Visualizer.new(0.0, 40.0 , 0.1)
# visualizer.calculatelogic(not_very_hot)
