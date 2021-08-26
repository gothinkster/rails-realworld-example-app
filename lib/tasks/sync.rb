desc 'Sync pull requests from Github'
task :sync => :environment do
    class ResponseError < StandardError
      def initialize(response, message, repository)
        super(message)

        @response   = response
        @repository = repository
      end

        # These errors seem to happen a lot, so avoid sending them to Bugsnag
        def skip_bugsnag
          is_a?(ForbiddenError) ||
            is_a?(RateLimitError) ||
            is_a?(ResolveError) ||
            is_a?(UnauthorizedError) ||
            is_a?(IPAllowListError)
        end

        private

        attr_reader :response, :repository
      end

      BadGatewayError   = Class.new(ResponseError)
      ForbiddenError    = Class.new(ResponseError)
      IPAllowListError  = Class.new(ResponseError)
      RateLimitError    = Class.new(ResponseError)
      ResolveError      = Class.new(ResponseError)
      UnauthorizedError = Class.new(ResponseError)
      UnknownQueryError = Class.new(ResponseError)

      if response.errors.any?
        message = response.errors[:data].join(", ")
        ex = build_response_error(message)
      end

      if response.data
        if response.data.pull_requests
          for i in 1..response.data.pull_requests.length() do
            @pull_request = PullRequest.new(response.data.pull_requests[i])
          end
        end
      end
      rescue Exception => ex
        raise ex
      end

      private

      def build_response_error(message)
        (
          case message
          when /401 Unauthorized/
            UnauthorizedError
          when /403 Forbidden/
            ForbiddenError
          when /API rate limit exceeded/
            RateLimitError
          when /Could not resolve to a/
            ResolveError
          when /502 Bad Gateway/
            BadGatewayError
          when /IP allow list enabled/
            IPAllowListError
          when /Something went wrong while executing your query/
            UnknownQueryError
          else
            ResponseError
          end
        ).new(response, message, repository)
      end

      def response
        client = Github::Graphql::Client.new("codeclimate", Rails.application.secrets.github_api_token)
        variables ||= { org: "codeclimate" }
        definition = parse_query <<-'GRAPHQL'
          {
          search(query: "org:$org is:pr created:>2019-04-01", type: ISSUE, last: 100) {
            edges {
              node {
                ... on PullRequest {
                  url
                  title
                  status
                }
              }
            }
          }
        }
        GRAPHQL
        @response ||= client.tap { logger.debug("Querying %s with %s" % [definition, variables.inspect]) }.
          query(definition, variables: variables)
      end
    end
  end
end