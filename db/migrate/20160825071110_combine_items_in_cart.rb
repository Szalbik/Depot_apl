class CombineItemsInCart < ActiveRecord::Migration[5.0]
  
  def up
    # zamiana wielu pozycji dla jednego przedmiotu jedną pozycją
    Cart.all.each do |cart|
      # zliczanie produktów w koszyku
      sums = cart.line_items.group(:product_id).sum(:quantity)
      
      sums.each do |product_id, quantity|
        if quantity > 1
          # usuwanie indywidualnych pozycji
          cart.line_items.where(product_id: product_id).delete_all
          
          # tworzenie pojedynczych pozycji
          item = cart.line_items.build(product_id: product_id)
          item.quantity = quantity
          item.save!
        end
      end
    end
  end
  
  def down
    # roździelenie pozycji z iloscia wielsza od 1 na pojedyncze 
    LineItem.where('quantity > 1').each do |line_item|
      # stworzenie indywidualnych pozycji
      line_item.quantity.times do 
        LineItem.create(
            cart_id: line_item.cart_id,
            product_id: line_item.product_id,
            quantity: 1
          )
      end
      # usuwanie pozycji z duzą iloscia
      line_item.destroy
    end
  end
  
end
