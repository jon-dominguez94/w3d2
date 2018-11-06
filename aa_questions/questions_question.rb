class Question
  
  attr_accessor :id, :title, :body, :user_id
  
  def initialize(option)  
    # id, title, body, user_id
    @id = option['id']
    @title = option['title']
    @body = option['body']
    @user_id = option['user_id']
  end
  
  
  def self.find_by_id(id)
    question = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT * FROM questions WHERE id = ?
    SQL
    # variable 'question' is an array of hashes
    # since we specify a unique id as argument, 
    # the return array will only have one hash element
    
    return nil if question.length == 0
    # thus, if the return array is empty, return nil as there is no row
    Question.new(question.first)
  end
  
end