class QuestionLike
  
  attr_accessor :id, :user_id, :question_id

  
  def initialize(option)
    @id = option['id']
    @user_id = option['user_id']
    @question_id = option['question_id']
  end
  
  def self.find_by_id(id)
    like = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT * FROM replies WHERE id = ?    
    SQL
    
    return nil if like.length == 0
    QuestionLike.new(like.first)
  end
  
end