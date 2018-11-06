require 'Singleton'
require 'sqlite3'

class QuestionsDatabase < SQLite3::Database
  include Singleton 

  def initialize
    super ('questions.db')
    self.results_as_hash = true
    # what does this do?
    self.type_translation = true
    # what does this do?
  end    
end

class User
  
  def initialize(options)
    @fname = options[:fname]
    @lname = options[:lname]
  end
    
  
end



