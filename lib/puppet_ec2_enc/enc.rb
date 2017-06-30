require 'yaml'

module PuppetEc2Enc
  class ENC
    attr_accessor :role_class, :environment

    def initialize(opts = {})
      @role_class  = opts[:role_class] || nil
      @environment = opts[:environment] || nil
    end

    def output
      classes = []
      classes << "#{role_class}" if role_class
      { 'classes' => classes, 'environment' => environment }.to_yaml
    end
  end
end
