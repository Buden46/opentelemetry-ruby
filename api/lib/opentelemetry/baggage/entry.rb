# frozen_string_literal: true

# Copyright The OpenTelemetry Authors
#
# SPDX-License-Identifier: Apache-2.0

module OpenTelemetry
  # OpenTelemetry Baggage Implementation
  module Baggage
    #just to test
    # Read-only representation of a baggage entry
    class Entry
      attr_reader :value, :metadata

      def initialize(value, metadata = nil)
        @value = value
        @metadata = metadata
      end
    end
  end
end
