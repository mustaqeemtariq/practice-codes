class Weather
  def temp_calculate(year, parameter)
    months = %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]
    month_temp = {}
    months.each do |month|
      next unless File.exist?("./lahore_weather/lahore_weather_#{year}_#{month}.txt")

      file = File.open("./lahore_weather/lahore_weather_#{year}_#{month}.txt")

      temp_list = []
      file.readlines.each do |line|
        temp_list << { line.split(',')[0] => line.split(',')[1].to_i } if parameter == 'max'
        temp_list << { line.split(',')[0] => line.split(',')[3].to_i } if parameter == 'min'
        temp_list << { line.split(',')[0] => line.split(',')[7].to_i } if parameter == 'humidity'
      end
      month_temp[month] = temp_list
    end
    temp_value(month_temp, parameter)
  end

  def month_calculate(month, year, parameter)
    file = File.open("./lahore_weather/lahore_weather_#{year}_#{month}.txt")
    temp_list = []
    file.readlines.each do |line|
      temp_list << { line.split(',')[0] => line.split(',')[1].to_i } if parameter == 'max'
      temp_list << { line.split(',')[0] => line.split(',')[3].to_i } if parameter == 'min'
      temp_list << { line.split(',')[0] => line.split(',')[7].to_i } if parameter == 'humidity'
    end
    month_value(temp_list, parameter)
  end
end

class YearWeather < Weather
  private

  def temp_value(temp_hash, parameter)
    temp_value = []
    temp_hash.each do |values|
      values[1].each do |hash|
        hash.each do |_date, temp|
          temp_value << temp.to_i unless temp.zero?
        end
      end
    end
    return temp_date(temp_hash, temp_value.max) if %w[max humidity].include?(parameter)
    return temp_date(temp_hash, temp_value.min) if parameter == 'min'
  end

  def temp_date(temp_hash, temp)
    date = []
    temp_hash.each do |values|
      values[1].each do |hash|
        date << hash.key(temp) unless hash.key(temp).nil?
      end
    end
    "#{date}: #{temp}C"
  end
end

class MonthWeather < Weather
  private

  def month_value(temp_hash, parameter)
    temp_value = []
    temp_hash.each do |value|
      value.each do |_date, temp|
        temp_value << temp.to_i unless temp.zero?
      end
    end
    return month_date(temp_hash, temp_value.max) if %w[max humidity].include?(parameter)
    return month_date(temp_hash, temp_value.min) if parameter == 'min'
  end

  def month_date(temp_hash, temp)
    date = []
    temp_hash.each do |value|
      date << value.key(temp) unless value.key(temp).nil?
    end
    "#{date}: #{temp}C"
  end
end

class Charts
  def graph(max, min)
    max.times do
      print '+'
    end
    print " #{max}C\n"
    min.times do
      print '-'
    end
    print " #{min}C\n"
  end
end

weather_month = MonthWeather.new
weather_year = YearWeather.new
chart = Charts.new

chart.graph(25, 10)
put 'Enter a month in this format Jan: '
month = gets.chomp
put 'Enter a year: '
year = gets.chomp
puts weather_year.temp_calculate(year, 'min')
puts weather_month.month_calculate('', 1996, 'min')
