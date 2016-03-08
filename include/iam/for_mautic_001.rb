_include 'include/iam/roles/basic_ec2.rb'

IAMForEC2 do
  Type "AWS::IAM::InstanceProfile"
  Properties do
    Path  "/"
    Roles [
      _{
        Ref "IAMRoleForEC2"
      }
    ]
  end
end
