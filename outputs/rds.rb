RDSEndpoint do
  Description "Endpoint of RDS"
  Value do
    Fn__GetAtt "RDSCluster", "Endpoint.Address"
  end
end
