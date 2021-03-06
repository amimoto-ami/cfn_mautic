ELB do
  Type "AWS::ElasticLoadBalancing::LoadBalancer"
  DependsOn "AttachGatewayToVPC"
  Properties do
    Subnets [
      _{
        Ref "PublicSubnet"
      }
    ]
    HealthCheck do
      HealthyThreshold   2
      Interval           30
      Target             "TCP:80"
      Timeout            10
      UnhealthyThreshold 2
    end
    Listeners [
      _{
        InstancePort      80
        LoadBalancerPort  80
        Protocol          "HTTP"
        InstanceProtocol  "HTTP"
      }
    ]
    Instances [
      _{
        Ref "EC2"
      }
    ]
    SecurityGroups [
      _{
        Ref "SecurityGroupInternal"
      },
      _{
        Ref "SecurityGroupPublic"
      }
    ]
  end
end
