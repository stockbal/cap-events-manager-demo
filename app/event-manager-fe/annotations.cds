using EventManager as service from '../../srv/EventsManager';

annotate service.Events with @( // UI Annotations
UI : {
    LineItem        : [
        {
            $Type : 'UI.DataField',
            Value : EventId,
        },
        {
            $Type : 'UI.DataField',
            Value : EventName,
        },
        {
            $Type  : 'UI.DataFieldForAction',
            Action : 'EventManager.ConfirmParticipation',
            Label  : 'Participate'
        },
        {
            $Type : 'UI.DataField',
            Value : EventDate,
        },
        {
            $Type : 'UI.DataField',
            Value : EventStart,
        },
        {
            $Type : 'UI.DataField',
            Value : EventEnd,
        },
    ],
    SelectionFields : [
        EventId,
        EventDate,
        EventStart,
        EventEnd
    ],
    Facets          : [
        {
            $Type  : 'UI.ReferenceFacet',
            Target : '@UI.Identification',
            Label  : 'General Facet'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : 'Participants',
            Target : 'Participants/@UI.LineItem'
        }
    ],
    Identification  : [
        {
            $Type : 'UI.DataField',
            Value : EventId,
        },
        {
            $Type : 'UI.DataField',
            Value : EventName,
        }
    ],
});

annotate service.Participants with @( //
UI : {LineItem : [
    {
        $Type : 'UI.DataField',
        Value : ParticipId,
    },
    {
        $Type : 'UI.DataField',
        Value : FirstName,
    },
    {
        $Type : 'UI.DataField',
        Value : LastName,
    },
    {
        $Type : 'UI.DataField',
        Value : Adress,
    },
], });
