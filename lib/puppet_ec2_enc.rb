require "puppet_ec2_enc/version"
require "puppet_ec2_enc/metadata"
require "puppet_ec2_enc/ec2tags"
require "puppet_ec2_enc/enc"

module PuppetEc2Enc
  def self.generate
    instance_id = PuppetEc2Enc::Metadata.instance_id
    region      = PuppetEc2Enc::Metadata.region
    ec2tags     = PuppetEc2Enc::EC2Tags.new(instance_id: instance_id, region: region)
    tags        = ec2tags.tags
    role        = tags.fetch('puppet_role')
    environment = tags.fetch('puppet_env')
    enc         = PuppetEc2Enc::ENC.new(role: role, environment: environment)
    enc.output
  end
end
