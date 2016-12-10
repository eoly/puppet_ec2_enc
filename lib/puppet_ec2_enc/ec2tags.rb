require 'aws-sdk'

module PuppetEc2Enc
  class EC2Tags
    attr_accessor :instance_id, :region, :ec2

    def initialize(opts = {})
      @instance_id = opts[:instance_id] if opts[:instance_id]
      @region      = opts[:region] if opts[:region]
      @ec2         = Aws::EC2::Resource.new(region: @region)
    end

    def tags
      tags = {}
      instance.tags.each do |tag|
        tags[tag[:key]] = tag[:value]
      end
      tags
    end

    private

    def instance
      ec2.instance(instance_id)
    end
  end
end
