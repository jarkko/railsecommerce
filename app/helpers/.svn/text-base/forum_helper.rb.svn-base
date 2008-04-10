module ForumHelper
  def display_as_threads(posts)
    content = ''
    for post in posts
      url = link_to("#{h post.subject}", {:action => 'show', :id => post.id})
      margin_left = post.depth*20
      content << %(
      <div style="margin-left:#{margin_left}px">
        #{url} by #{h post.name} &middot; #{post.created_at.localize(DEFAULT_DATE_FORMAT)}
      </div>)
    end
    content
  end
end
