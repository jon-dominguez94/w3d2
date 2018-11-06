class QuestionFollows
  
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
    QuestionFollows.new(follow.first)
  end
  
  
end