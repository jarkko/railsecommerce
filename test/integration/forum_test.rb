require "#{File.dirname(__FILE__)}/../test_helper"

class ForumTest < ActionController::IntegrationTest

  def test_post_and_reply_with_two_users
    christian = enter_forum(:christian)
    post = christian.start_thread('Subject', 'Body text')
    
    jarkko = enter_forum(:jarkko)
    jarkko.view_post(post)
#    jarkko.reply_to_post(post, 'Reply subject', 'Reply body text')
  end

  private

  module ForumTestDSL
    attr_writer :name
    
    def view_forum
      get "/forum"

      assert_response :success
      assert_template "forum/index"
      assert_not_nil %r(<h1>Forum</h1>).match(@response.body)
    end
    
    def start_thread(subject, body)
      get "/forum/post"
      assert_response :success
      assert_template "forum/post"

      post "/forum/create", {"post[parent_id]" => 0, 
        "post[name]" => @name, 
        "post[subject]" => subject,
        "post[body]" => body}

      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_template "forum/index"
      assert_not_nil Regexp.new(Regexp.escape(subject)).match(@response.body)
      post = ForumPost.find_by_subject(subject)
      return post
    end
    
    def view_post(post)
      get "/forum/show/#{post.id}"

      assert_response :success
      assert_template "forum/show"
      assert_not_nil Regexp.new(Regexp.escape(post.subject)).match(@response.body)
    end
    
    def reply_to_post(post, subject, body)
      get "/forum/reply/#{post.id}"
      assert_response :success
      assert_not_nil Regexp.new(Regexp.escape("Reply to '#{post.subject}'")).match(@response.body)
    
      post "/forum/create", {"post[parent_id]" => post.id, 
        "post[name]" => @name, 
        "post[subject]" => subject,
        "post[body]" => body}

      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_template "forum/index"
      assert_not_nil Regexp.new(Regexp.escape(subject)).match(@response.body)
    end
  end
  
  def enter_forum(name)
    open_session do |session|
      session.extend(ForumTestDSL)
      session.name = name
      session.view_forum
      yield session if block_given?
    end
  end
  
end
