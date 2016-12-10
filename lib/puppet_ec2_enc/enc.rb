require 'yaml'

module PuppetEc2Enc
  class ENC
    attr_accessor :role, :environment

    def initialize(opts = {})
      @role        = opts[:role] || nil
      @environment = opts[:environment] || nil
    end

    def output
      classes = []
      classes << "role::#{role}" if role
      { 'classes' => classes, 'environment' => environment }.to_yaml
    end
  end
end
