class Quiz < ActiveRecord::Base
  has_many :responses
  has_and_belongs_to_many :sounds, :join_table => "quiz_sounds"
  has_and_belongs_to_many :responses, :join_table => "quizzes_responses"
  has_and_belongs_to_many :users
  serialize :quiz_answers, Array

  validates :which_grbas_letter, presence: true
  validates :difficulty, presence: true
  validates :num_questions, presence: true

  def self.build_quiz(grbas_letter, difficulty, num_questions, user_id)
    # Assert that the grbas_letter is valid
    quiz = Quiz.new

    grbas_letter.downcase!
    if ["g", "r", "b", "a", "s"].include?(grbas_letter) && difficulty >= 0 && num_questions > 0
      quiz = Quiz.new(which_grbas_letter: grbas_letter)
      # Get the sounds for the quiz based on num_questions and difficulty
      # 0 is hard, 1 is medium, 2 is medium, 3 is easy
      question_answers = []
      sounds = []
      responses = []
      0.upto(num_questions - 1) do |i|
        question_answers << (generate_random_number(difficulty, 1) % 4).round.to_i
        sound = Sound.get_sound(grbas_letter, question_answers[i])
        while sounds.include?(sound)
          sound = Sound.get_sound(grbas_letter, question_answers[i])
        end
        sounds << sound
        quiz.sounds << sound

        response = Response.new(sound_id: sound.id, quiz_id: quiz.id, user_id: user_id)
        response.save
        responses << response
      end

      quiz.responses = responses
      quiz.quiz_answers = question_answers
      quiz.user_id = user_id
      quiz.difficulty = difficulty
      quiz.num_questions = num_questions
      quiz.created_at = DateTime.now
      end
    quiz
  end

  def self.translate_letter(grbas_letter)
    case grbas_letter
    when "g"
        return "Grade"
    when "r"
        return "Roughness"
    when "b"
        return "Breathiness "
    when "a"
        return "Asthenia"
    when "s"
        return "Strain"
    else
        return "Unknown letter"
    end
  end

  private

  def self.generate_random_number(mean, std)
    gauss_rand = Random.new
    mean + gauss_rand.rand * std
  end
end
