class QuizzesController < ApplicationController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy]
  before_action :set_current_user

  # GET /quizzes
  # GET /quizzes.json
  def index
    render file: "#{Rails.root}/public/404.html", status: :not_found
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
                            @current_user.id
    if @quiz.save
      flash[:notice] = "Quiz created successfully!"
      unless @current_user.nil?
        @current_user.quizzes << @quiz
      end
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
  quiz_params[:responses].each do |response|
    @response = Response.find_by_id(response[0])
    @response.update({:rating => response[1][:rating], :reasoning => response[1][:reasoning], :quiz_id => @quiz.id})
    feedback = @response.create_feedback
    @response.update({:feedback => feedback})
  end
  if @quiz.save
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
      params.require(:quiz).permit(:which_grbas_letter, :difficulty, :num_questions, responses: [:rating, :reasoning])
    end
end
