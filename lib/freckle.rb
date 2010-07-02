require 'yajl' unless defined?(Yajl)
require 'streamly' unless defined?(Streamly)

LEGACY_KEYS = %w[project entry]  # backward compatibility

module Apis
  module Freckle
    module ApiObject
      def initialize(hash)
        legacy_key = hash.keys.select {|k| LEGACY_KEYS.include?(k) }.first
        if legacy_key
          @hash = hash[legacy_key]
        else
          @hash = hash
        end
      end
      
      def method_missing(method, *args)
        unless LEGACY_KEYS.include?(method)
          @hash[method.to_s]
        else
          @hash
        end
      end
    end
  end
end

base = File.expand_path(File.dirname(__FILE__))
require base + '/freckle/base'
require base + '/freckle/project'
require base + '/freckle/entry'
