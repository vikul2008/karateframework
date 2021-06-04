function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://jsonplaceholder.typicode.com'
  }
  if (env == 'dev') {
    config.id = '5'
     config.username = 'Kamren'

  } else if (env == 'qa') {
   config.id = '5'
   config.username = 'Kamren'
  }

//Code to assign header for the entire project
//  var varHeaderCookie = karate.callSingle('classpath:helpers/commonList.feature',config).headerCookie
//  karate.configure('headers',Cookie:varHeaderCookie)
//  var varHeaderContentType = karate.callSingle('classpath:helpers/commonList.feature',config).headerContentType
//  karate.configure('headers',Content-Type:varHeaderContentType)
  return config;
}