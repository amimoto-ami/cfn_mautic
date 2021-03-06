_path("/opt/aws/cloud_formation.json") do
	content '{
	  "rds" : {
		"database" : "mautic",
		"username" : "amiage",
		"password" : "{{password}}",
		"endpoint" : "{{endpoint}}",
		"port"     : 3306
	  }
	}'
  context do
	endpoint do
	  Fn__GetAtt "RDSCluster", "Endpoint.Address"
	end
	password do
	  Ref "MySQLPassword"
	end
  end
  mode "00644"
  owner "root"
  group "root"
end
