require "#{File.dirname(__FILE__)}/../test_helper"

class PublisherTest < ActionController::IntegrationTest
  def test_publisher_administration_interface
    new_session do |admin|
      admin.opens_publisher_page
      admin.opens_new_publisher_page
      admin.adds_publisher 'Apress'
      admin.opens_show_publisher_page 'Apress'
      admin.opens_edit_publisher_page 'Apress'
      admin.edits_publisher 'Apress', 'Apress.com'
    end
  end

  private

  module TestingDSL
    def opens_publisher_page
      get "/admin/publisher"
      assert_response :success
      assert_template "admin/publisher/list"    
    end

    def opens_new_publisher_page
      get "/admin/publisher/new"
      assert_response :success
      assert_template "admin/publisher/new"
    end

    def adds_publisher(name)
      post "/admin/publisher/create", "publisher[name]" => name
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_template "admin/publisher/list"
      assert_tag :tag => 'td', :content => name
    end

    def opens_show_publisher_page(name)
      publisher = Publisher.find_by_name(name)
      get "/admin/publisher/show/#{publisher.id}"
      assert_template "admin/publisher/show"
    end

    def opens_edit_publisher_page(name)
      publisher = Publisher.find_by_name(name)
      get "/admin/publisher/edit/#{publisher.id}"
      assert_template "admin/publisher/edit"
    end

    def edits_publisher(name, new_name)
      publisher = Publisher.find_by_name(name)
      post "/admin/publisher/update/#{publisher.id}", "publisher[name]" => new_name
      follow_redirect!
      assert_response :success
      assert_template "admin/publisher/show"
    end

    def deletes_publisher()
      publisher = Publisher.find_by_name(name)
      post "/admin/publisher/destroy/#{publisher.id}"
      follow_redirect!
      assert_response :success
      assert_template "admin/publisher/list"
    end
  end
  def new_session
    open_session do |session|
      session.extend(TestingDSL)
      yield session if block_given?
    end
  end
end
