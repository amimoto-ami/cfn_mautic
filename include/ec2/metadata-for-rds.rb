_path("/opt/aws/cloud_formation.json") do
	content '{
	  "rds" : {
		"database" : "rdsdb",
		"username" : "amiage",
		"password" : "{{password}}",
		"endpoint" : "{{endpoint}}",
		"port"     : 3306
	  }
	}'
  context do
	endpoint do
	  Fn__GetAtt "RDS", "Endpoint.Address"
	end
	password do
	  Ref "MySQLPassword"
	end
  end
  mode "00644"
  owner "root"
  group "root"
end
