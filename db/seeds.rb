5.times do |index|
  post = Post.create(
    title:      "Title #{index.next}",
    content:    "Content #{index.next}",
    created_at: (Time.now - index.days)
  )
  puts post.title
end
