using EventManager from './EventsManager';

annotate EventManager.Events with {
    @title : 'Event Id'
    EventId;

    @title : 'Name'
    EventName;

    @title : 'Date'
    EventDate;

    @title : 'Start'
    EventStart;

    @title : 'End'
    EventEnd;
};

annotate EventManager.Participants with {
    @title : 'Event Id'
    EventId;

    @title : 'Participant Id'
    ParticipId;

    @title : 'First Name'
    FirstName;

    @title : 'Last Name'
    LastName;

    @title : 'Adress'
    Adress;
};
