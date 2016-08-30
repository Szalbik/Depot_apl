require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  # test "the truth" do
  #   assert true
  # end
  
  test "product attributes must not be empty" do 
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any? 
    assert product.errors[:price].any? 
    assert product.errors[:image_url].any?
  end
  
  test 'product price must be positive' do
    product = Product.new(title: 'My Book Title',
                          description: "yyy",
                          image_url: "zzz.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal [I18n.translate("errors.messages.greater_equal_0_01")], 
      product.errors[:price]
      
    product.price = 0
    assert product.invalid?
    assert_equal [I18n.translate("errors.messages.greater_equal_0_01")], product.errors[:price]
      
    product.price = 1
    assert product.valid?
  end
  
  def new_product(image_url)
    Product.new(title: "My book is coll",
                description: "aaaaaaaa",
                price: 1,
                image_url: image_url)
  end
  
  test 'image url' do
    ok = %w{ fred.jpg fred.gif fred.png Fred.JPG fred.Jpg http://abcs/a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.docj fred.gif/more fred.gif.more }
    
    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end
    
    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
  end
  
  test 'products is not valid without unique title' do 
    #puts(products(:ruby).inspect)
    product = Product.new(products(:ruby).attributes)
    
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end
  
  test 'title should have 10 signs' do
    product = Product.new(title: "My book",
                          description: "aaaa",
                          price: 1,
                          image_url: "fred.gif")
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.min_ten_chars')], product.errors[:title]
  end
  
end
