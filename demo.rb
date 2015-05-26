require 'book_discussion_client'

BookDiscussionClient.config(end_point: 'http://localhost:5000')
client = BookDiscussionClient.instance
puts 'Discussions:'
puts client.discussions.map { |discussion| "#{discussion.id}: #{discussion.title}" }

puts 'Response:'
puts client.discussion(1).responses.first.responses[0]

discussion = BookDiscussionClient::Discussion.new(
  'author_id' => '1',
  'book_id' => '12345',
  'title' => 'Test discussion',
  'subject' => 'Created from demo.rb',
)
saved_discussion = client.save_discussion(discussion)
puts 'Saved discussion:'
puts saved_discussion.as_json

response = BookDiscussionClient::Response.new(
  'author_id' => '2',
  'comment' => 'Test response to test discussion',
)
saved_response = client.save_response(response, saved_discussion)
puts 'Saved response:'
puts saved_response.as_json

response = BookDiscussionClient::Response.new(
  'author_id' => '1',
  'comment' => 'Test response to test response',
)
saved_response = client.save_response(response, saved_response)
puts 'Saved response to response:'
puts saved_response.as_json
