require 'rubygems'
require 'bundler/setup'

require 'open-uri'
Bundler.require(:default)

require 'anekdot'
require 'anekdots_access'

# function to parce anekdots by date
def parse_by_date(date)
  url = "https://anekdot.ru/release/anekdot/day/#{date}/"
  html = open(url)
  doc = Nokogiri::HTML(html)
  access = AnekdotAccess.new
  doc.css('.text').each do |elem|
    if elem.css('img').length == 0 then
      access.insert(Anekdot.new elem.text, date)
    end
  end
end

puts "Введите дату, с которой загрузить анекдоты"

date = gets.chomp

parse_by_date(date)