require File.dirname(__FILE__) + '/../test_helper'
require 'admin_controller'

# Re-raise errors caught by the controller.
class AdminController; def rescue_action(e) raise e end; end

class AdminControllerTest < Test::Unit::TestCase
  fixtures :items
  fixtures :users 

  def setup
    @controller = AdminController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    get :index, {}, {:user => users(:bob)}
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list, {}, {:user => users(:bob)}

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:items)
  end

  def test_show
    get :show, {:id => 1}, {:user => users(:bob)}

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:item)
    assert assigns(:item).valid?
  end

  def test_new
    get :new, {}, {:user => users(:bob)}

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:item)
  end
   
  def test_new_without_login
      get :new
      assert_redirected_to :controller => 'account', :action => 'login'      
  end

  def test_create
  
   
    num_items = Item.count

    post :create, {:item => {}, :larrytext => 'take out the trash', :create_date => {'month' => 9, 'year' => 2007, 'day' => 14}, :tag_list => "travel" } , {:user => users(:bob)}

    assert_response :redirect
    assert_redirected_to :action => 'show'

   assert_equal num_items + 1, Item.count
  end

  def test_edit    
    get :edit, {:id => 1}, {:user => users(:bob)}

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:item)
    assert assigns(:item).valid?
  end

  def test_update
    post :update, {:id => 1, :tag_list => "flibber",:create_date => {'month' => 9, 'year' => 2007, 'day' => 14} }, {:user => users(:bob)}
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

 # def test_destroy
#    assert_not_nil Item.find(1)

 #   post :destroy, :id => 1
  #  assert_response :redirect
  # assert_redirected_to :action => 'list'

  #  assert_raise(ActiveRecord::RecordNotFound) {
  #    Item.find(1)
  #  }
  # end
end
