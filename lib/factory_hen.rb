require "factory_hen/version"

##
# FactoryHen is a factory for creating valid models
#
# Inspired by FactoryGirl and done because the Rails 5
# support wasnt implemented yet.

module FactoryHen
  class Configuration
    attr_accessor :factories
    def initialize
      @factories = {}
    end

    def define(model, &block)
      @factories[model] = block
    end
  end

  def self.configure
    @config ||= Configuration.new
    yield @config
  end

  def self.create(model, params={})
    obj = build(model, params)
    obj.save
    obj
  end

  def self.new(model, params={})
    build(model, params)
  end

  def self.params(model, params={})
    defaults = @config.factories[model].call || {}
    combined = defaults.merge(params)

    # Check if any params needs to be saved
    saved = combined.each_with_object({}) do |(l, v), collection|
      if v.respond_to?(:save)
        key = "#{v.class.name.downcase}_id".to_s
        v.save
        collection[key] = v.id
      end
    end

    combined.merge(saved)
  end

  class << self
    private def build(model, params)
      defaults = @config.factories[model].call
      record = model.to_s.capitalize

      Kernel.const_get(record).new.tap do |obj|
        obj.attributes = defaults if defaults
        obj.attributes = params
      end
    end
  end
end
