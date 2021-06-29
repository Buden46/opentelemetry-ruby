# frozen_string_literal: true

# Copyright The OpenTelemetry Authors
#
# SPDX-License-Identifier: Apache-2.0

module OpenTelemetry
  module SDK
    module Trace
      # Class that holds global trace parameters.
      class SpanLimits
        # The global default max number of attributes per {Span}.
        attr_reader :attribute_count_limit

        # The global default max length of attribute value per {Span}.
        attr_reader :attribute_length_limit

        # The global default max number of {OpenTelemetry::SDK::Trace::Event}s per {Span}.
        attr_reader :event_count_limit

        # The global default max number of {OpenTelemetry::Trace::Link} entries per {Span}.
        attr_reader :link_count_limit

        # The global default max number of attributes per {OpenTelemetry::SDK::Trace::Event}.
        attr_reader :attribute_per_event_count_limit

        # The global default max number of attributes per {OpenTelemetry::Trace::Link}.
        attr_reader :attribute_per_link_count_limit

        # Returns a {SpanLimits} with the desired values.
        #
        # @return [SpanLimits] with the desired values.
        # @raise [ArgumentError] if any of the max numbers are not positive.
        def initialize(attribute_count_limit: Integer(ENV.fetch('OTEL_SPAN_ATTRIBUTE_COUNT_LIMIT', 128)), # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
                       attribute_length_limit: ENV['OTEL_RUBY_SPAN_ATTRIBUTE_VALUE_LENGTH_LIMIT'],
                       event_count_limit: Integer(ENV.fetch('OTEL_SPAN_EVENT_COUNT_LIMIT', 128)),
                       link_count_limit: Integer(ENV.fetch('OTEL_SPAN_LINK_COUNT_LIMIT', 128)),
                       attribute_per_event_count_limit: attribute_count_limit,
                       attribute_per_link_count_limit: attribute_count_limit)
          raise ArgumentError, 'attribute_count_limit must be positive' unless attribute_count_limit.positive?
          raise ArgumentError, 'attribute_length_limit must not be less than 32' unless attribute_length_limit.nil? || Integer(attribute_length_limit) >= 32
          raise ArgumentError, 'event_count_limit must be positive' unless event_count_limit.positive?
          raise ArgumentError, 'link_count_limit must be positive' unless link_count_limit.positive?
          raise ArgumentError, 'attribute_per_event_count_limit must be positive' unless attribute_per_event_count_limit.positive?
          raise ArgumentError, 'attribute_per_link_count_limit must be positive' unless attribute_per_link_count_limit.positive?

          @attribute_count_limit = attribute_count_limit
          @attribute_length_limit = attribute_length_limit.nil? ? nil : Integer(attribute_length_limit)
          @event_count_limit = event_count_limit
          @link_count_limit = link_count_limit
          @attribute_per_event_count_limit = attribute_per_event_count_limit
          @attribute_per_link_count_limit = attribute_per_link_count_limit
        end

        # The default {SpanLimits}.
        DEFAULT = new
      end
    end
  end
end