require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/author_controller'

# Re-raise errors caught by the controller.
class Admin::AuthorController; def rescue_action(e) raise e end; end

class Admin::AuthorControllerTest < Test::Unit::TestCase
  fixtures :authors
  
  def setup
    @controller = Admin::AuthorController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_create
    get :new
    assert_template 'admin/author/new'
    Author.destroy_all
    
    assert_equal 0, Author.find(:all).size
    post :create, :author => {:first_name => "Dave", 
                              :last_name => "Thomas"}
    assert_response :redirect
    assert_redirected_to :action => "list"
    assert_equal 1, Author.find(:all).size
    assert_equal "Dave", Author.find(:first).first_name
    assert_equal 'Author was successfully created.', flash[:notice]
  end
  
  def test_failing_create
    assert_no_difference Author, :count do
      post :create, :author => {:first_name => "Dave"}
      assert_response :success
      assert_template 'admin/author/new'
      assert_tag :tag => 'div', :attributes => 
        {:class => 'fieldWithErrors'} 
    end
  end
  
  def test_list
    get :list
    assert_response :success
    assert_tag  :tag => "table",
                :children => { :count => 3,
                               :only => {:tag => "tr" } }
    assert_tag  :tag => "td",
                :content => "Dave"
    assert_tag  :tag => "td",
                :content => "Thomas"
                
    assert_tag  :tag => "td",
                :content => "Andy"
    assert_tag  :tag => "td",
                :content => "Hunt"
  end
  
  def test_edit
    get :edit, :id => 1
    
    assert_tag  :tag => "input",
                :attributes => { :name => "author[first_name]",
                                 :value => "Dave" }
    assert_tag  :tag => "input",
                :attributes => { :name => "author[last_name]",
                                 :value => "Thomas" }
    
    post :update, :id => 1, :author => { :first_name => "David",
                                         :last_name => "Thomas" }
    assert_response :redirect
    assert_redirected_to :action => "show", :id => 1 
    
    assert_equal "David", Author.find(1).first_name
  end
  
  def test_show
    get :show, :id => 1
    assert_template "admin/author/show"
    assert_equal "Dave", assigns(:author).first_name
    assert_equal "Thomas", assigns(:author).last_name
  end
  
  def test_destroy
    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => "list"
    assert_equal 1, Author.find(:all).size
  end
end
