require 'pg'
require 'anekdot'

# function for getting anekdots by word from database
def get_by_word(word)
  connection_work do |con| 
    rs = con.exec "SELECT * FROM anekdots WHERE text LIKE '%#{word}%' ORDER BY date"
    arr = Array.new()
    rs.each do |row|
      arr.push(Anekdot.new(row['text'], row['date']))
    end
    return arr
  end
end

# function for writing anekdots to database
def insert(anekdot)
  text = anekdot.text
  date = anekdot.date
  connection_work do |con| 
    con.exec "INSERT INTO anekdots (text, date) VALUES ('#{text}', '#{date}');"
  end
end

#function with block, gets connection to db
def connection_work(&block)
  begin
    con = PG.connect :dbname => 'ruby_course', :user => 'ruby', :password => 'password'
    return block.call con
  rescue PG::Error => e
    puts e.message 
  ensure
    con.close if con
  end
end