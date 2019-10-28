require 'anekdot'
require 'anekdots_access'

require 'open-uri'
require 'nokogiri'
# function to parce anekdots by date
def parse_by_date(date)
  url = "https://anekdot.ru/release/anekdot/day/#{date}/"
  html = open(url)
  doc = Nokogiri::HTML(html)
  doc.css('.text').each do |elem|
    if elem.css('img').length == 0 then
      insert(Anekdot.new elem.text, date)
    end
  end
end

puts "Введите дату, с которой загрузить анекдоты"

date = gets.chomp

parse_by_date(date)