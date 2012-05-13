require File.dirname(__FILE__) + '/../test_helper'
require 'account_controller'

# Raise errors beyond the default web-based presentation
class AccountController; def rescue_action(e) raise e end; end

class AccountControllerTest < Test::Unit::TestCase
  self.use_instantiated_fixtures  = true
  
  fixtures :users
  
  def setup

    @controller = AccountController.new
    @request, @response = ActionController::TestRequest.new, ActionController::TestResponse.new
    @request.host = "localhost"
  end
  
  
  
  def test_auth_bob
    @request.session['return-to'] = "/bogus/location"

    post :login, "user_login" => "bob", "user_password" => "test"
    
    assert(@response.has_session_object?(:user))

    assert_equal @bob, session[:user]
    
    assert_redirected_to "/bogus/location"
  end
  
  
  def test_signup
    @request.session['return-to'] = "/bogus/location"
    
    post :login, "user_login" => "bob", "user_password" => "test"

    post :signup, "user" => { "login" => "newbob", "password" => "newpassword", "password_confirmation" => "newpassword" }
  
  #assert_not_nil session[:user]  
    assert(@response.has_session_object?(:user))     
  assert_equal "newbob", session[:user].login
    
   # assert_redirected_to "/bogus/location"
  end
  
  
  
  def test_password_confirmation   
   
    user = User.new( { "login" => "newbob", "password" => "newpassword", "password_confirmation" => "wrong"  } )
   
   
   assert !user.valid?
   assert user.errors.on(:password)
  end

def test_username_length
  
  user = User.new(  { "login" => "yo", "password" => "newpassword", "password_confirmation" => "newpassword" })
  
  
   
   assert !user.valid?
   assert user.errors.on(:login)
   
end


  def test_bad_signup
    @request.session['return-to'] = "/bogus/location"   
  
    user = User.new( { "login" => "yo", "password" => "newpassword", "password_confirmation" => "wrong" })
   
    
     assert !user.valid?
     assert user.errors.on(:login)
     assert user.errors.on(:password)
   
    
  end
  
 def test_invalid_login
    post :login, "user_login" => "bob", "user_password" => "not_correct"
     
    assert(!@response.has_session_object?("user"))     
    assert(@response.has_template_object?("message"))
    assert(@response.has_template_object?("login"))
    
end
  
  def test_login_logoff

    post :login, "user_login" => "bob", "user_password" => "test"
    assert(@response.has_session_object?(:user))     

    get :logout
    assert(!@response.has_session_object?(:user))    

  end
  
end
