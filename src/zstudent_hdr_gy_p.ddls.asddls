@EndUserText.label: 'Projection View for Header Table'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity zstudent_hdr_gy_p
  provider contract transactional_query
  as projection on zstudent_hdr_gy_i
{

      @UI.facet: [{

          id: 'StudentData',
          purpose: #STANDARD,
          label: 'Student Data',
          type: #IDENTIFICATION_REFERENCE,
          position: 10
       },{
          id: 'Upload',
          purpose: #STANDARD,
          label: 'Upload Attachments',
          type: #LINEITEM_REFERENCE,
          position: 20,
          targetElement: '_Attachments'
       }]

      @UI: {
          selectionField: [{ position: 10 }],
          lineItem: [{ position: 10,

                       label: 'Update Status📌',
                       type: #FOR_ACTION,
                       dataAction: 'statusUpdate',
                       invocationGrouping: #ISOLATED },

                       {type: #FOR_ACTION, dataAction: 'copyStudent', label: 'Copy Student 👩‍🏫'},
                       {type: #FOR_ACTION, dataAction: 'createInstance', label: 'Create Instance ✔'}],
          identification: [{ position: 10 }]
      }

  key Id,
      @UI: {
      lineItem: [{ position: 20 }],
      identification: [{ position: 20 }]
      }
      Firstname,
      @UI: {
      lineItem: [{ position: 30 }],
      identification: [{ position: 30 }]
      }
      Lastname,
      @UI: {
      lineItem: [{ position: 40 }],
      identification: [{ position: 40 }]
      }
      Age,
      @UI: {
      lineItem: [{ position: 50 }],
      identification: [{ position: 50 }]
      }
      Course,
      @UI: {
      lineItem: [{ position: 60 }],
      identification: [{ position: 60 }]
      }
      Courseduration,
      @UI: {
      lineItem: [{ position: 70 } ],

      identification: [{ position: 70 }]
      }
      Status,
      @UI: {
      lineItem: [{ position: 80 }],
      identification: [{ position: 80 }]
      }
      Gender,
      @UI: {
      lineItem: [{ position: 90 }],
      identification: [{ position: 90 }]
      }
      Dob,
      Lastchangedat,
      Locallastchangedat,
      /* Associations */
      _Attachments : redirected to composition child zstudent_att_gy_p
}
