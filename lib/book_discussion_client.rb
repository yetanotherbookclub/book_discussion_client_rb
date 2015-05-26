require 'book_discussion_client/client'

module BookDiscussionClient
  def self.instance
    Thread.current['book_discussion_client'] ||= Client.new(end_point: @end_point)
  end

  def self.config(end_point:)
    @end_point = end_point
  end
end
