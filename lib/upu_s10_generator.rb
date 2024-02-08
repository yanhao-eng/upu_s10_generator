# frozen_string_literal: true

require_relative "upu_s10_generator/version"
require_relative "upu_s10_generator/base"

module UpuS10Generator
  class Error < StandardError; end

  def new(service_indicator, sequence, country_code)
    return new Base(service_indicator, sequence, country_code)
  end
  
end
