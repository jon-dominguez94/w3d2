class QuestionFollow
  
  attr_accessor :id, :user_id, :question_id
  
  def initialize(option)
    @id = option['id']
    @user_id = option['user_id']
    @question_id = option['question_id']
  
  end
  
  def self.find_by_id(id)
    follow = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT * FROM question_follows WHERE id = ?    
    SQL
    
    return nil if follow.length == 0
    QuestionFollow.new(follow.first)
  end
  
  
  def self.followers_for_question_id(question_id)
    #return an array of user objects
    
    # what_is_user_id = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    #   SELECT user_id FROM question_follows WHERE question_id = ?    
    # SQL
    # 
    # users_arr = QuestionsDatabase.instance.execute(<<-SQL, what_is_user_id)
    #   SELECT * FROM users WHERE id = ?    
    # SQL
    # 
    # return nil if users_arr.empty?
    # users_arr.map {|u| User.new(u)}
    
    users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT 
        u.*
      FROM 
        users AS u 
      JOIN
        question_follows AS f
      WHERE 
        question_id = ? 
        AND 
          u.id = f.user_id
    SQL
    
    return nil if users.empty?
    users.map {|u| User.new(u)}  
  end
  
  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT 
        q.*
      FROM
        questions AS q
      JOIN
        question_follows AS qf
      WHERE
        qf.user_id = ?
        AND
          q.id = qf.question_id
    SQL
    
    return nil if questions.empty?
    questions.map {|q| Question.new(q)}
  end
  
end