RDSEndpoint do
  Description "Endpoint of RDS"
  Value do
    Fn__GetAtt "RDS", "Endpoint.Address"
  end
end
