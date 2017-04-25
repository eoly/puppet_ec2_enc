require 'aws-sdk'

module PuppetEc2Enc
  class EC2Tags
    attr_accessor :instance

    def initialize(opts = {})
      @instance = opts[:instance] if opts[:instance]
    end

    def tags
      tags = {}
      instance.tags.each do |tag|
        tags[tag[:key]] = tag[:value]
      end
      tags
    end
  end
end
