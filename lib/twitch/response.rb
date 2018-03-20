module Twitch
  # A compiled response from the API.
  class Response
    # The requested data.
    attr_reader :data
    # A total amount of entities.
    # Applies to select endpoints.
    attr_reader :total
    # A range of dates in which data is effective.
    # Usually contains the keys start_date and end_date.
    # Applies to select endpoints.
    attr_reader :date_range
    # A hash containing a pagination token. 
    # Access it with
    #    pagination['cursor']
    # Applies to select endpoints. 
    attr_reader :pagination
    # The total amount of calls that can be used in
    # the rate limit period (one minute by default).
    attr_reader :rate_limit
    # The remaining amount of calls for the rate limit period.
    attr_reader :rate_limit_remaining
    # The date at which the rate limit is reset.
    attr_reader :rate_limit_resets_at
    # The total amount of clips that can be created in
    # the clip rate limit period (currently unknown).
    attr_reader :clip_rate_limit
    # The remaining amount of clips that can be created in 
    # the clip rate limit period. 
    attr_reader :clip_rate_limit_remaining

    def initialize(data, rate_limit_headers, pagination = nil, total = nil, date_range = nil)
      @data = data

      @rate_limit = rate_limit_headers[:limit].to_i
      @rate_limit_remaining = rate_limit_headers[:remaining].to_i
      @rate_limit_resets_at = Time.at(rate_limit_headers[:reset].to_i)

      if rate_limit_headers.keys.any? { |k| k.to_s.start_with?('helixclipscreation') }
        @clip_rate_limit = rate_limit_headers[:'helixclipscreation-limit']
        @clip_rate_limit_remaining = rate_limit_headers[:'helixclipscreation-remaining']
      end

      @pagination = pagination
      @total = total
      @date_range = date_range
    end
  end
end