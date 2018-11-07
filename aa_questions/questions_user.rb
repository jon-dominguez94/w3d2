require 'Singleton'
require 'sqlite3'
require_relative 'questions_question'
require_relative 'questions_qfollow'
require_relative 'questions_reply'
require_relative 'questions_like'

class QuestionsDatabase < SQLite3::Database
  include Singleton 

  def initialize
    super ('questions.db')
    self.results_as_hash = true
    # what does this do? all the rows into a hash object
    self.type_translation = true
    # what does this do?
  end    
end

class User
  
  attr_accessor :id, :fname, :lname
  
  def initialize(options)
    @id = options['id']
    # name of key, not actual value 'id'
    @fname = options['fname']
    @lname = options['lname']
  end
  
  def self.find_by_id(id)
    # lookup an 'id' in the table & return an object that represent 'row'
    # User::find_by_id should return an instance of User class (NOT data hash return by QuestionsDatabase)
    user =  QuestionsDatabase.instance.execute(<<-SQL, id) 
      SELECT * FROM users WHERE id = ?
    SQL
    return nil unless user.length > 0
    User.new(user.first)
  end
  
  def self.find_by_name(fname, lname)
    user =  QuestionsDatabase.instance.execute(<<-SQL, fname, lname) 
      SELECT * FROM users WHERE fname = ? AND lname = ?
    SQL
    
    return nil unless user.length > 0
    User.new(user.first)  
  end
  
  
  def authored_questions
    # questions = QuestionsDatabase.instance.execute(<<-SQL, @id)
    #   SELECT * FROM questions WHERE user_id = ?
    # SQL
    # 
    # return nil if questions.empty?
    # questions.map {|q| Question.new(q)}  
    Question.find_by_author_id(@id)  
  end
  
  def authored_replies
    # replies = QuestionsDatabase.instance.execute(<<-SQL, @id)
    #   SELECT * FROM replies WHERE user_id = ?
    # SQL
    # 
    # return nil if replies.empty?
    # replies.map {|r| QuestionReply.new(r)}
    
    Reply.find_by_user_id(self.id)
  end
end



