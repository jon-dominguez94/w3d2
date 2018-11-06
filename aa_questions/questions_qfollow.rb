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
end