# 温度 と 湿度
# ベタ打ち
temperature  = 23.0 #℃ 温度
humidity     = 65.2 #% 湿度
=begin
# コマンドラインから入力
print "温度を入力してください\n"
temperature  = gets.to_i #℃ 温度
print "湿度を入力してください\n"
humidity     = gets.to_i #% 湿度
=end


require('./logic/Fuzzy_logic')
very_hot        = Fuzzy_logic.new(18.0, 30.0, "up")
not_very_hot    = Fuzzy_logic.new(20.0, 10.0, "down")
very_humid      = Fuzzy_logic.new(50.0, 80.0, "up")
not_very_humid  = Fuzzy_logic.new(70.0, 40.0, "down")

require('./logic/Implementation_logic')
raise_temp = Implementation_logic.new(7.0)
lower_temp = Implementation_logic.new(-8.0)

# プロットデータの生成
# require('./util/Visualizer')

=begin
IF THEN 条件
前件部               後件部
暑い     湿度が高い
NO.1  YES     YES         温度をさげる （lower_temp）
NO.2  YES     NO          温度をさげる （lower_temp）
NO.3  NO      YES         温度をあげる （raise_temp）
NO.4  NO      NO          温度をあげる （raise_temp）
=end

# 前件部と後件部に対応するfuzzy集合をセット
logic_functions     = [very_hot,   not_very_hot,  very_humid, not_very_humid]
implement_functions = [lower_temp, lower_temp,    raise_temp, raise_temp]

def calculate_fit (temperature, humidity, logic_functions)
  fit = []
  fit[0] = [ logic_functions[0].membership_func(temperature), logic_functions[2].membership_func(humidity) ].min
  fit[1] = [ logic_functions[0].membership_func(temperature), logic_functions[3].membership_func(humidity) ].min
  fit[2] = [ logic_functions[1].membership_func(temperature), logic_functions[2].membership_func(humidity) ].min
  fit[3] = [ logic_functions[1].membership_func(temperature), logic_functions[3].membership_func(humidity) ].min
  return fit
end

def calculateresult(tmp, implement_functions, fit)
  [
    [ implement_functions[0].implement(tmp), fit[0] ].min,
    [ implement_functions[1].implement(tmp), fit[1] ].min,
    [ implement_functions[2].implement(tmp), fit[2] ].min,
    [ implement_functions[3].implement(tmp), fit[3] ].min
  ].max
end

def de_fazzy(from_temp, to_tmp, pitch, implement_functions, fit)
  itr = ( (to_tmp - from_temp) / pitch ).ceil.to_i #timesメソッドを使うために整数に変換
  moment = 0  #非fazzy化の分母となるモーメントを初期化
  area = 0    #非fazzy化の分子となる面積を初期化
  itr.times do |i|
    moment += calculateresult( (from_temp + pitch * i ), implement_functions, fit) * pitch * (from_temp + pitch * i )
    area   += calculateresult( (from_temp + pitch * i ), implement_functions, fit) * pitch
  end
  return area === 0 ? 0 : moment / area
end

fit = calculate_fit(temperature, humidity, logic_functions)

# 結果のプロット
# 200.times do |i|
#   pitch = 0.1
#   puts  "#{-10 + i*pitch}, #{calculateresult(-10 + i*pitch, lower_temp, lower_temp, raise_temp, raise_temp, fit)}"
# end

p fit
p de_fazzy(-10.0, 10.0, 0.1, implement_functions, fit)
