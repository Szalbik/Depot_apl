class AdminController < ApplicationController
  def index
    time = Time.now
    @curr_time = time.strftime("%A  |  %d.%m.%Y  |  %H:%M:%S")
    @total_orders = Order.count
  end
end
