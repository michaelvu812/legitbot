# frozen_string_literal: true

require 'irrc'

module Legitbot # :nodoc:
  # https://developers.facebook.com/docs/sharing/webmasters/crawler
  class Facebook < BotMatch
    AS = 'AS32934'

    ip_ranges do
      client = Irrc::Client.new
      client.query :radb, AS
      results = begin
                  client.perform
                rescue
                  {}
                end

      %i[ipv4 ipv6].map do |family|
        next if results.blank? || (as = results[AS]).blank? || (ipv = as[family]).blank?

        ipv[AS]
      end.compact.flatten
    end
  end

  rule Legitbot::Facebook, %w[Facebot facebookexternalhit/1.1]
end
