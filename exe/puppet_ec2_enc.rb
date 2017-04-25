#!/usr/bin/env ruby

require 'puppet_ec2_enc'

raise ArgumentError.new(
  'Usage: puppet_ec2_enc <node>'
) unless ARGV.count == 1

node = ARGV[0]

puts PuppetEc2Enc.generate(node)
