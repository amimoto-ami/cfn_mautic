WebSiteURL do
  Description "Site URL"
  Value do
    Fn__Join [
      "",
      [
        "http://",
        _{
          Fn__GetAtt "ELB", "DNSName"
        }
      ]
    ]
  end
end
