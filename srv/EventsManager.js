const cds = require("@sap/cds");

// Remote service needs valid CSRF tokens for changing data via (POST, PUT, PATCH, DELETE)
cds.env.features.fetch_csrf = true;

module.exports = cds.service.impl(async function () {
  const service = await cds.connect.to("Events");

  this.on("READ", ["Events", "Participants"], (request) => {
    console.log("READ executed by " + request.user);
    return service
      .tx(request)
      .send({ query: request.query, headers: { userid: request.user } });
  });

  this.on("PUT", ["Events", "Participants"], (request) => {
    console.log("UPDATE executed by " + request.user);
    return service.tx(request).put("EventSet", request.data);
  });

  this.on("CREATE", ["Events", "Participants"], (request) => {
    console.log("CREATE executed by " + request.user);
    
    return service.tx(request).run(request.query);
  });

  this.on("ConfirmParticipation", async (request) => {
    console.log('Execute action "ConfirmParticipation"...');

    // Create new participation for the given event via a create call on the associated entity
    return service
      .tx(request)
      // request.params[0] contains the key objectto the EventSet entity set
      .run(INSERT.into("ParticipantSet", request.params[0]));
  });
});
