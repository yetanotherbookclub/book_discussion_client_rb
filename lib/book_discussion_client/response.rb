require 'active_model'

module BookDiscussionClient
  class Response
    include ActiveModel::Model
    include ActiveModel::Serialization
    include ActiveModel::Serializers::JSON

    attr_accessor :id,
                  :author_id,
                  :comment,
                  :responses,
                  :url,
                  :discussion_id

    def attributes
      {
        'id' => id,
        'author_id' => author_id,
        'comment' => comment,
        'responses' => responses,
        'url' => url
      }
    end

    def responses=(attributes)
      @responses ||= []
      attributes.each do |response_params|
        @responses.push(Response.new({'discussion_id' => discussion_id}.merge(response_params)))
      end
    end
  end
end
