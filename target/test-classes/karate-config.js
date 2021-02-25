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

//KarateUser1234 karate123 KarateUser1234@user.com
// {user: {email: "KarateUser1234@user.com", password: "karate123", username: "KarateUser1234"}}
// {"user":{"id":144808,"email":"karateuser1234@user.com","createdAt":"2021-02-25T07:35:43.357Z","updatedAt":"2021-02-25T07:35:43.363Z","username":"KarateUser1234","bio":null,"image":null,"token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTQ0ODA4LCJ1c2VybmFtZSI6IkthcmF0ZVVzZXIxMjM0IiwiZXhwIjoxNjE5NDIyNTQzfQ.g9kLDaiztuUnfaSksskoOXkWYcVVIOZkTyJcNcYgU6M"}}