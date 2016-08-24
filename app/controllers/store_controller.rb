class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    @time = "#{Time.now.year}" + "-" + "#{Time.now.month}" + "-" + "#{Time.now.day}" + "  | " + "#{Time.now.hour}" + ":" + "#{Time.now.min}" + ":" + "#{Time.now.sec}"
  end
end
