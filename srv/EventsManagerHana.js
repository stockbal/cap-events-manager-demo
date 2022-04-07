const cds = require("@sap/cds");

module.exports = cds.service.impl(async function () {
  const ExtEventsService = await cds.connect.to("ExtEventsAPI");

  this.before("READ", "Events", genericBeforeRead("Events"));
  this.after("READ", "Events", genericAfterRead("Events"));
  this.after("READ", "Participants", (req) => {});

  this.before(
    "READ",
    "Events/SiblingEntity",
    genericBeforeRead("Event/SiblingEntity")
  );

  this.after(
    "READ",
    "Events/SiblingEntity",
    genericAfterRead("Events/SiblingEntity")
  );

  this.after("draftPrepare", (req) => {
    console.log("After draftPrepare");
    console.log("------>");
    console.log(req);
    console.log("<------");
  });

  // Apparently not really necessary???
  // this.on("draftPrepare", (req) => {});

  this.before("draftActivate", (req) => {
    console.log("Before draftActivate");
  });

  this.after("draftActivate", (req) => {
    console.log("After draftActivate");
    console.log("------>");
    console.log(req);
    console.log("<------");
  });

  this.before("NEW", "Events", async (req) => {
    const { EventId } = await cds
      .tx(req)
      .run(SELECT.one.from(req.target).columns("max(EventId) as EventId"));
    req.data.EventId = parseInt(EventId) + 1;
  });

  this.before("NEW", "Participants", async (req) => {
    const { ParticipId } = await cds
      .tx(req)
      .run(
        SELECT.one
          .from(req.target)
          .columns("max(ParticipId) as ParticipId")
          .where({ EventId: req.data.EventId })
      );
    req.data.ParticipId =
      ParticipId === null ? "100" : parseInt(ParticipId) + 1;
    console.log(`New Participant Id: ${ParticipId}`);
  });
});

const genericBeforeRead = (entityName) => (req) => {
  console.log(`Before reading ${entityName} ------>`);
  console.log(req.query.SELECT);
  console.log("<---------------------");
};

const genericAfterRead = (entityName) => (req) => {
  console.log(`After reading ${entityName} ------>`);
  console.log(req);
  console.log("<---------------------");
};
