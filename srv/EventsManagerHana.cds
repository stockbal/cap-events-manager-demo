namespace srv;

using {db} from '../db/schema';

// @requires : 'authenticated-user'
service EventManagerHana {
    entity Events       as projection on db.Events;
    entity Participants as projection on db.Participants;
}
