 # class for working with anecdots
class Anekdot
  # text: Text of Anecdot
  # date: date of this anecdot in format: yyyy-mm-dd
  attr_reader :text, :date

  # init of text and date
  def initialize(text, date)
    @text = text
    @date = date
  end
end