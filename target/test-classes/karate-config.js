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

  // Only set default credentials if not already provided as parameters
  if (env == "dev") {
    config.userEmail = karate.get("userEmail", "elosvadel84@gmail.com");
    config.userPassword = karate.get("userPassword", "Osva12345");
  } else if (env == "qa") {
    // customize
    config.userEmail = karate.get("userEmail", "elosvadel84@test.com");
    config.userPassword = karate.get("userPassword", "Osva123456");
  } else if (env == "perf") {
    // performance testing - don't set defaults, use passed parameters
    config.userEmail = karate.get("userEmail");
    config.userPassword = karate.get("userPassword");
  }
  return config;
}
