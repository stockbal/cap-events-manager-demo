namespace db;

type Name : String(50);
type Id : String(3);

entity Events {
        @title : '{i18n>eventId}'
    key EventId      : Id;
        @title : '{i18n>eventDate}'
        EventDate    : Date;
        @title : '{i18n>eventName}'
        EventName    : String(200);
        @title : '{i18n>eventStart}'
        EventStart   : Time;
        @title : '{i18n>eventEnd}'
        EventEnd     : Time;

        Participants : Composition of many Participants
                           on Participants.EventId = $self.EventId;
}

entity Participants {
        @title : '{i18n>eventId}'
    key EventId    : Id;
        @title : '{i18n>participantId}'
    key ParticipId : Id;
        @title : '{i18n>participantFirstName}'
        FirstName  : Name;
        @title : '{i18n>participantLastName}'
        LastName   : Name;
        @title : '{i18n>participantAddress}'
        Address    : String;
}

annotate Events with @odata.draft.enabled;
