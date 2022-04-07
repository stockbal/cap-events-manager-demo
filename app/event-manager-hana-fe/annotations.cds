using srv.EventManagerHana as service from '../../srv/EventsManagerHana';

annotate service.Events with @( //
UI : {
    HeaderInfo : {
        TypeName       : 'Event',
        TypeNamePlural : 'Events',
        Description    : {
            $Type : 'UI.DataField',
            Value : EventName,
        },
    },
    LineItem   : [
        {
            $Type : 'UI.DataField',
            Value : EventId,
        },
        {
            $Type : 'UI.DataField',
            Value : EventDate,
        },
        {
            $Type : 'UI.DataField',
            Value : EventName,
        },
        {
            $Type : 'UI.DataField',
            Value : EventStart,
        },
        {
            $Type : 'UI.DataField',
            Value : EventEnd,
        },
    ]
});

annotate service.Events with @( //
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            {
                $Type : 'UI.DataField',
                Value : EventId,
            },
            {
                $Type : 'UI.DataField',
                Value : EventDate,
            },
            {
                $Type : 'UI.DataField',
                Value : EventName,
            },
            {
                $Type : 'UI.DataField',
                Value : EventStart,
            },
            {
                $Type : 'UI.DataField',
                Value : EventEnd,
            }
        ],
    },
    UI.Facets                      : [
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'GeneratedFacet1',
            Label  : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'ParticipantsTableFacet',
            Label  : 'Participants',
            Target : 'Participants/@UI.LineItem'
        }
    ]
);

annotate service.Participants with @( //
UI.LineItem : [
    {
        $Type : 'UI.DataField',
        Value : ParticipId,
    },
    {
        $Type : 'UI.DataField',
        Value : FirstName
    },
    {
        $Type : 'UI.DataField',
        Value : LastName,
    },
    {
        $Type : 'UI.DataField',
        Value : Address,
    }
]);

// suppresses popup to fill out key fields
annotate service.Events with {
    @Core.Computed
    EventId;
}
