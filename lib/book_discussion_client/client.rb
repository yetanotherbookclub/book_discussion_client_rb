require 'faraday'
require 'faraday_middleware'
require 'book_discussion_client/discussion'
require 'book_discussion_client/response'

module BookDiscussionClient
  class Client
    def initialize(end_point:)
      @end_point = end_point
    end

    def discussions
      get(discussions_endpoint).map do |data|
        Discussion.new(data)
      end
    end

    def discussion(id)
      Discussion.new(get(discussion_endpoint(id)))
    end

    def save_discussion(discussion)
      raise 'Cannot modify existing discussion' if discussion.id

      Discussion.new(post(discussions_endpoint, discussion))
    end

    def save_response(response, in_response_to)
      raise 'Cannot modify existing response' if response.id

      discussion_id = nil
      result = nil
      if in_response_to.is_a? Discussion
        discussion_id = in_response_to.id
        result = Response.new(post(discussion_responses_endpoint(in_response_to.id), response))
      elsif in_response_to.is_a? Response
        discussion_id = in_response_to.discussion_id
        result = Response.new(post(response_responses_endpoint(in_response_to.discussion_id, in_response_to.id), response))
      else
        raise "Unsupported type: '#{in_response_to.class.name}'"
      end

      result.discussion_id = discussion_id
      result
    end

    protected

    def discussions_endpoint
      '/discussions'
    end

    def discussion_endpoint(discussion_id)
      "/discussions/#{discussion_id}"
    end

    def discussion_responses_endpoint(discussion_id)
      "/discussions/#{discussion_id}/responses"
    end

    def response_responses_endpoint(discussion_id, response_id)
      "/discussions/#{discussion_id}/responses/#{response_id}/responses"
    end

    def connection
      @connection ||= Faraday.new(url: @end_point) do |faraday|
        faraday.request :json
        faraday.response :json, content_type: /\bjson$/
        faraday.adapter  Faraday.default_adapter
      end
    end

    def get(path)
      connection.get(path).body
    end

    def post(path, object)
      connection.post do |req|
        req.url path
        req.headers['Content-Type'] = 'application/json'
        req.body = object.as_json
      end.body
    end
  end
end
