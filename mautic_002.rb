AWSTemplateFormatVersion "2010-09-09"
Description (<<-EOS).undent
  This is AMIAGE Mautic Stack made by CloudFormation.
EOS

Mappings do
  _include "mautic/ami_hvm.rb"
end

Parameters do
  _include "params/keyname.rb"
  _include "params/ssh_location.rb"
  _include "params/subnets.rb"
  _include "params/ec2_instance.rb"
  _include "params/rds_settings.rb"
end

Conditions do
  CreateSecDB do
    Fn__Equals [
      _{ Ref "MulitiAZDatabase" },
      true
    ]
  end
end


Resources do
  _include "include/vpc/vpc.rb"
  _include 'include/ec2/waithandle_ec2.rb'
  _include "include/ec2/ec2-with-rds.rb"
  _include "include/rds/rds.rb"
  _include "include/security_group.rb"
  _include "include/elb.rb"
  _include "include/iam/for_mautic_001.rb"
end

Outputs do
  _include "outputs/ec2.rb"
  _include "outputs/elb.rb"
  _include "outputs/rds.rb"
end
