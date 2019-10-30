require 'anekdot'
require 'anekdots_access'

puts "Введите слово для поиска"

word = gets.chomp

access = AnekdotAccess.new

anekdots = access.get_by_word word

anekdots.each do |elem|
  puts "#{elem.date} : \n#{elem.text}\n\n"
end

if anekdots.length == 0 then
  puts "Не найдено"
end