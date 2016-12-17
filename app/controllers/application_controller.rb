class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_time, :authorize
  
  def set_time
      @time = "#{Time.now.year}-#{Time.now.month}-#{Time.now.day} | #{Time.now.hour}:#{Time.now.min}:#{Time.now.sec}"
  end

  protected

    def authorize
      unless User.find_by(id: session[:user_id])
        redirect_to login_url, notice: "Please log in"
      end
    end
end
