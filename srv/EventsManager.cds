using {Events as external} from './external/Events.csn';

@requires : 'authenticated-user'
service EventManager {

    // @readonly
    entity Events       as projection on external.EventSet {
        key EventId,
            EventName,
            EventDate,
            EventStart,
            EventEnd,
            Participants
    }
    // bound actions
    actions {
        action ConfirmParticipation() returns Participants
    }

    @readonly
    entity Participants as projection on external.ParticipantSet {
        key ParticipId,
            EventId,
            FirstName,
            LastName,
            Adress
    }
}
