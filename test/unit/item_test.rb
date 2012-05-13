require File.dirname(__FILE__) + '/../test_helper'

class ItemTest < Test::Unit::TestCase
  fixtures :items

  def setup
    @item = Item.find(1)
  end

 
  def test_create
    assert_kind_of Item,  @item
    assert_equal 1, @item.id
    assert_equal "1995-06-26 00:00:00", @item.create_date_before_type_cast
    assert_equal 208, @item.number
    assert_equal "LA" , @item.act_type
    assert_equal "Learn shiatsu massage", @item.item_desc        
  end
  
  def test_update
	  assert_equal 208, @item.number 
	  @item.number = 2108
	  assert @item.save, @item.errors.full_messages.join("; ")
	  @item.reload
	  assert_equal 2108, @item.number
  end
  
 # def test_destroy
	#  @item.destroy
	#  assert_raise(ActiveRecord::RecordNotFound) { Item.find(@item.id) }
 # end
  
  def test_new_next
	  mything = Item.new_next
	  assert mything.number = 1686
  end 


end
