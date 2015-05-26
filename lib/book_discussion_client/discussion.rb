require 'active_model'

module BookDiscussionClient
  class Discussion
    include ActiveModel::Model
    include ActiveModel::Serialization
    include ActiveModel::Serializers::JSON

    attr_accessor :id,
                  :author_id,
                  :book_id,
                  :title,
                  :subject,
                  :responses,
                  :url

    def attributes
      {
        'id' => id,
        'author_id' => author_id,
        'book_id' => book_id,
        'title' => title,
        'subject' => subject,
        'responses' => responses,
        'url' => url
      }
    end

    def responses=(attributes)
      @responses ||= []
      attributes.each do |response_params|
        @responses.push(Response.new({'discussion_id' => id}.merge(response_params)))
      end
    end
  end
end
