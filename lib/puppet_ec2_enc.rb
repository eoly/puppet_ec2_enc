require "puppet_ec2_enc/version"
require "puppet_ec2_enc/instance"
require "puppet_ec2_enc/metadata"
require "puppet_ec2_enc/ec2tags"
require "puppet_ec2_enc/enc"

module PuppetEc2Enc
  def self.generate(fqdn)
    region      = ENV.fetch('AWS_DEFAULT_REGION') { |value| PuppetEc2Enc::Metadata.region }
    client      = PuppetEc2Enc::Instance.client(region)
    instance    = client.by_private_dns(fqdn)
    ec2tags     = PuppetEc2Enc::EC2Tags.new(instance: instance)
    tags        = ec2tags.tags
    role        = tags.fetch('puppet_role')
    environment = tags.fetch('puppet_env')
    enc         = PuppetEc2Enc::ENC.new(role: role, environment: environment)
    enc.output
  end
end
