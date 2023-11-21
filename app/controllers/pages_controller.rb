class PagesController < ApplicationController

  skip_before_filter :set_current_user

  def about
  end

end
