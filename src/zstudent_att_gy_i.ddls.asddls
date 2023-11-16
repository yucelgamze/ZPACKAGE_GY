
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View for Attachment'
define view entity Zstudent_Att_Gy_I as select from zstudent_att_gy
association to parent zstudent_hdr_gy_i as _Student
on $projection.Id = _Student.Id
{
    key zstudent_att_gy.attach_id as AttachId,
    zstudent_att_gy.id as Id,
    @EndUserText.label: 'Comments'
    zstudent_att_gy.comments as Comments,
    
    @EndUserText.label: 'Attachments'
//  bu dosyayı yükleme seçeneğini gösterecek olan ana annotation  
    @Semantics.largeObject:{
        mimeType: 'Mimetype',
        fileName: 'Filename',
        contentDispositionPreference: #ATTACHMENT
        
//        eğer #inline dersek tarayıcıda açıyor annotation'a eşlersek indiriyor
    }
    
    zstudent_att_gy.attachment as Attachment,
    @EndUserText.label: 'File Type'
    zstudent_att_gy.mimetype as Mimetype,
    @EndUserText.label: 'File Name'
    zstudent_att_gy.filename as Filename,
    
    _Student.Lastchangedat as LastChangedat,
    _Student // Make association public
}
