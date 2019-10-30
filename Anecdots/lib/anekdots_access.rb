require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require 'anekdot'
class AnekdotAccess
  attr_reader :con

  def initialize 
    begin
      @con = PG.connect :dbname => 'ruby_course', :user => 'ruby', :password => 'password'
    rescue PG::Error => e
      puts e.message
    end
  end

  # method for getting anekdots by word from database
  def get_by_word(word)
    connection_work do
      rs = @con.exec "SELECT * FROM anekdots WHERE text LIKE '%#{word}%' ORDER BY date"
      arr = Array.new()
      rs.each do |row|
        arr.push(Anekdot.new(row['text'], row['date']))
      end
      return arr
    end
  end

  # method for writing anekdots to database
  def insert(anekdot)
    text = anekdot.text
    date = anekdot.date
    connection_work do
      @con.exec "INSERT INTO anekdots (text, date) VALUES ('#{text}', '#{date}');"
    end
  end

  # method with block, gets connection to db
  def connection_work(&block)
    begin
      return block.call
    rescue PG::Error => e
      puts e.message 
    end
  end
end