 function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }

//  var generateUUID = function() { return java.util.UUID.randomUUID().toString()};

  var config = {
	baseUrl: "https://conduit.productionready.io/api/"
  }

  if (env == 'dev') {
    config.userEmail = 'karate@user.com'
    config.userPassword = 'karate123'
  } else if (env == 'qa') {
    config.userEmail = 'karate2@user.com'
    config.userPassword = 'karate1234'
  }

//  var accessToken = karate.callSingle('../../helpers/CreateToken.feature', config).authToken
//  karate.configure('headers', {Authorization: 'Token ' + accessToken})

  return config
}