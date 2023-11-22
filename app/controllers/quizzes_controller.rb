class QuizzesController < ApplicationController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy]

  # GET /quizzes
  # GET /quizzes.json
  def index
    @quizzes = Quiz.all
  end

  # GET /quizzes/1
  # GET /quizzes/1.json
  def show
  end

  # GET /quizzes/new
  def new
    @quiz = Quiz.new
  end

  # GET /quizzes/1/edit
  def edit
  end

  # POST /quizzes
  # POST /quizzes.json
  def create
    @quiz = Quiz.build_quiz params[:quiz][:which_grbas_letter],
                            params[:quiz][:difficulty].to_i,
                            params[:quiz][:num_questions].to_i,
                            session[:user_id]
    if @quiz.save
      flash[:notice] = "Quiz created successfully!"
      redirect_to quiz_path(@quiz)
    else
      flash[:alert] = "Quiz creation failed!"
      render :new
    end
  end

  # PATCH/PUT /quizzes/1
  # PATCH/PUT /quizzes/1.json
  # app/controllers/quizzes_controller.rb
def update
  @quiz = Quiz.find(params[:id])
  if @quiz.update(quiz_params)
    redirect_to about_path
  else
    render :edit
  end
end

  # DELETE /quizzes/1
  # DELETE /quizzes/1.json
  def destroy
    @quiz.destroy
    respond_to do |format|
      format.html { redirect_to quizzes_url, notice: 'Quiz was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quiz_params
      params.require(:quiz).permit(:which_grbas_letter, :difficulty, :num_questions)
    end
end
