@EndUserText.label: 'Projection View for Attachment'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity zstudent_att_gy_p
  as projection on Zstudent_Att_Gy_I
{
      @UI.facet: [{

      id: 'AttachmentInformation',
      purpose: #STANDARD,
      label: 'Attachment Information',
      type: #IDENTIFICATION_REFERENCE,
      position: 10
      }]

      @UI: {
      lineItem: [{ position: 10 }],
      identification: [{ position: 10 }]
      }

  key AttachId,
      @UI: {
      lineItem: [{ position: 20 }],
      identification: [{ position: 20 }]
      }
      Id,
      @UI: {
      lineItem: [{ position: 30 }],
      identification: [{ position: 30 }]
      }
      Comments,
      @UI: {
      lineItem: [{ position: 40 }],
      identification: [{ position: 40 }]
      }
      Attachment,
      Mimetype,
      Filename,
      LastChangedat,
      /*Associations*/
      _Student : redirected to parent zstudent_hdr_gy_p
}
