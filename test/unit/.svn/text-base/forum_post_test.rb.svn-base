require File.dirname(__FILE__) + '/../test_helper'

class ForumPostTest < Test::Unit::TestCase
  fixtures :authors


  def test_create_post_and_reply    
    post = ForumPost.new( :name => 'Christian', 
      :subject => 'Subject', 
      :body => 'Body text')
    
    assert post.save
    assert_not_nil ForumPost.find_by_name('Christian')
    
    reply = ForumPost.new(:name => 'Jarkko', 
      :subject => 'Reply', 
      :body => 'Reply body text',
      :parent_id => post.id)
      
    assert reply.save
    assert reply.child?
    
    post.reload
    
    assert post.root?
    assert_equal 1, post.all_children().size    
  end
  
end
