class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_time
  
  def set_time
      @time = "#{Time.now.year}-#{Time.now.month}-#{Time.now.day} | #{Time.now.hour}:#{Time.now.min}:#{Time.now.sec}"
  end
  
end
