IAMRoleForEC2 do
  Type "AWS::IAM::Role"
  Properties do
    ManagedPolicyArns [
      "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
    ]
    AssumeRolePolicyDocument do
      Version "2012-10-17"
      Statement do
        Effect "Allow"
        Principal do
          Service "ec2.amazonaws.com"
        end
        Action [
          "sts:AssumeRole"
        ]
      end
    end
    Path "/"
  end
end
