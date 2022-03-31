# cap-events-manager-demo

Demo UI5 application with CAP service that accesses a remote service

## Encountered Problems

### OnPremise Service connection during local testing

If you want to access a service on the OnPremise system during development you have to do the following _one_ steps:

- Deploy your application to cloud foundry
- Enable SSH connection to the application

  ```sh
  cf enable-ssh <app-name>
  ```

- Restart the application via `cf restart <app-name>`
- Retrieve the enviroment variables via `cf env <app-name>` and copy the variable `VCAP_SERVICES` together with its content into a file `default-env.json` in the root folder of the project.
  The file should then look like this:

  ```json
  {
    "VCAP_SERVICES": {
      ...
    }
  }
  ```

- Inspect the value of the entry connectivity of your `VCAP_SERVICES` and take note of the values of the fields
  - credentials.onpremise_proxy_port
  - credentials.onpremise_proxy_host

> We'll refer to these values as `proxy-port` and `proxy-host` hereafter.

- Create an SSH session to your app container with the following command and let the session opened:

  ```sh
  cf ssh app-name -L proxy-port:proxy-host:proxy-port
  ```

- Replace the value of the field `VCAP_SERVICES.connectivity.credentials.onpremise_proxy_host` in your default-env.json with localhost.
- Now you can test your application with `cds watch` against your OnPremise server

### Using POST/PUT/PATCH/DELETE http methods in remote service calls to OnPremise systems

Normally these kind of http calls are protected via CSRF so a valid token has to be present in the request header.
To enable the token handling when a remote OnPremise service is called the environment flag `cds.env.features.fetch_csrf` has to be set to `true`.  
This can either be done at the start of the service handler file:

e.g.

```js
const cds = require("@sap/cds");

// Remote service needs valid CSRF tokens for changing data via (POST, PUT, PATCH, DELETE)
cds.env.features.fetch_csrf = true;

module.exports = cds.service.impl(async function () {
  // handler code
});
```

or in a custom bootstrap file `server.js` in the project root directory

```js
const cds = require("@sap/cds");

// Remote service needs valid CSRF tokens for changing data via (POST, PUT, PATCH, DELETE)
cds.env.features.fetch_csrf = true;

// ... some custom bootstrapping ...
module.exports = cds.server; //> delegate to default server.js
```
