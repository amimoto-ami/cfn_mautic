    AvailabilityZone do
      Ref "AvailabilityZone"
    end
    DisableApiTermination "false"
    EbsOptimized "false"
    ImageId do
      Fn__FindInMap [
        "MPAMIs",
        _{ Ref "AWS::Region" },
        "AMI"
      ]
    end
    InstanceInitiatedShutdownBehavior "stop"
    InstanceType {
      Ref "InstanceType"
    }
    KeyName {
      Ref "KeyName"
    }
    Monitoring "false"
    SubnetId do
      Ref "PublicSubnet"
    end
    Tenancy "default"
    SecurityGroupIds [
      _{
        Ref "SecurityGroupInstance"
      },
      _{
        Ref "SecurityGroupInternal"
      }
    ]
    IamInstanceProfile do
      Ref "IAMForEC2"
    end
    UserData do
      Fn__Base64 do
        Fn__Join [
          "",
          [
            "#!/bin/bash\n",
            "/opt/aws/bin/cfn-init -s ",
            _{
              Ref "AWS::StackName"
            },
            " -r EC2 ",
            " --region ",
            _{
              Ref "AWS::Region"
            },
            "\n",
            "until [ -f /var/www/html/install_amiage.php ]  ; do sleep 5 ; done", "\n",
            "until host ",
            _{
              Fn__GetAtt [
                "RDSCluster",
                "Endpoint.Address"
              ]
            },
            "; do sleep 5 ; done",
            "\n",
            "until /usr/bin/mysqladmin -h ",
            _{
              Fn__GetAtt [
                    "RDSCluster",
                    "Endpoint.Address"
              ]
            },
            " -uamiage ",
            " -p",
            _{ Ref "MySQLPassword" },
            " status",
            "; do sleep 5 ; done",
            "\n",
            "rm -f /var/www/html/app/bootstrap.php.cache",
            "\n",
            "rm -rf /var/www/html/app/cache/*",
            "\n",
            "rm -f /var/www/html/app/config/local.php",
            "\n",
            "chown apache.apache /var/www/html/",
            "\n",
            "/usr/bin/chef-apply /opt/lw1/cfn_appendix/cfn_appendix.rb --json-attributes /opt/aws/cloud_formation.json", "\n",
            "cd /var/www/html ; sudo -u apache /usr/bin/php app/console doctrine:fixtures:load --env=prod --append --fixtures=app/bundles/InstallBundle/InstallFixtures/ --no-interaction ; cd -", "\n",
            "/opt/aws/bin/cfn-signal -e 0 -r \"CFn setup complete\" '",
            _{ Ref "EC2WaitHandle" }, "'\n"
          ]
        ]
      end
    end
