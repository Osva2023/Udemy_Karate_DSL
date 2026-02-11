function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log("karate.env system property was:", env);
  if (!env) {
    env = "dev";
  }
  var config = {
    env: env,
    myVarName: "someValue",
    apiUrl: "https://conduit-api.bondaracademy.com/api/",
  };
  if (env == "dev") {
    config.userEmail = "elosvadel84@gmail.com";
    config.userPassword = "Osva12345";
  } else if (env == "qa") {
    // customize
    config.userEmail = "elosvadel84@test.com";
    config.userPassword = "Osva123456";
  } else if (env == "perf") {
    // performance testing
    config.userEmail = "elosvadel84@gmail.com";
    config.userPassword = "Osva12345";
  }
  return config;
}
