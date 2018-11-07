class QuestionReply
  
  attr_accessor :id, :user_id, :question_id, :parent_reply_id, :body

  
  def initialize(option)
    @id = option['id']
    @user_id = option['user_id']
    @question_id = option['question_id']
    @parent_reply_id = option['parent_reply_id']
    @body = option['body']
  
  end
  
  def self.find_by_id(id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT * FROM replies WHERE id = ?    
    SQL
    
    return nil if reply.length == 0
    QuestionReply.new(reply.first)
  end
  
  def self.find_by_user_id(user_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT * FROM replies WHERE user_id = ?
    SQL
    
    return nil if replies.length == 0
    replies.map {|r| QuestionReply.new(r)}  
  end  
  
  def self.find_by_question_id(question_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT * FROM replies WHERE question_id = ?
    SQL
    
    return nil if replies.length == 0
    replies.map {|r| QuestionReply.new(r)}    
  end
  
  
  def author
    User.find_by_id(@user_id)
  end
  
  def question
    Question.find_by_id(@question_id)
  end
  
  def parent_reply
    QuestionReply.find_by_id(@parent_reply_id)
  end
  
  def child_replies
    replies = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT * FROM replies WHERE parent_reply_id = ?
    SQL
    
    return nil if replies.empty?
    replies.map {|r| QuestionReply.new(r)}
  end  
end