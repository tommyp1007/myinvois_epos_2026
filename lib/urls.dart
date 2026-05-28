// https://dev.epos.myinvois.hasil.gov.my/web/login (MW Cloud)
// https://uat.epos.myinvois.hasil.gov.my/web/login (MW Cloud)
// https://preprod-epos.comulo.com/web/login (SEA Cloud)
// https://preprod.epos.myinvois.hasil.gov.my/web/login (MW Cloud)
// https://epos.myinvois.hasil.gov.my/web/login (SEA Cloud) --------> Current Production
// https://mw-epos.comulo.com/web/login (MW Cloud)

class ApiUrls {
  // --- BASE / LOGIN URLs ---
  static const String dev = 'https://dev.epos.myinvois.hasil.gov.my/web/login'; // MW Cloud
  static const String uat = 'https://uat.epos.myinvois.hasil.gov.my/web/login'; // MW Cloud
  static const String preProd = 'https://preprod.epos.myinvois.hasil.gov.my/web/login'; // MW Cloud
  static const String production = 'https://epos.myinvois.hasil.gov.my/web/login'; // SEA Cloud (Current Production)

  // --- LOGOUT URLs ---
  static const String devLogout = 'https://dev.epos.myinvois.hasil.gov.my/web/session/logout';
  static const String uatLogout = 'https://uat.epos.myinvois.hasil.gov.my/web/session/logout';
  static const String preProdLogout = 'https://preprod.epos.myinvois.hasil.gov.my/web/session/logout';
  static const String productionLogout = 'https://epos.myinvois.hasil.gov.my/web/session/logout';

  // ----------------------------------------------------------------------
  // ALTERNATIVE CLOUD ENVIRONMENTS (Included for reference)
  // ----------------------------------------------------------------------
  
  // SEA Cloud Pre-Production
  // static const String preProdSea = 'https://preprod-epos.comulo.com/web/login';
  // static const String preProdSeaLogout = 'https://preprod-epos.comulo.com/web/session/logout';

  // MW Cloud Production
  // static const String productionMw = 'https://mw-epos.comulo.com/web/login';
  // static const String productionMwLogout = 'https://mw-epos.comulo.com/web/session/logout';

}
