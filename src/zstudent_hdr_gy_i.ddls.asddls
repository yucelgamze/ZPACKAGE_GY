@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View Entity for Student'
define root view entity zstudent_hdr_gy_i as select from zstudent_hdr_gy
composition[1..*] of Zstudent_Att_Gy_I as _Attachments
{
    
    @EndUserText.label: 'Student ID'
    key zstudent_hdr_gy.id as Id,
    @EndUserText.label: 'First Name'
    zstudent_hdr_gy.firstname as Firstname,
    @EndUserText.label: 'Last Name'
    zstudent_hdr_gy.lastname as Lastname,
    @EndUserText.label: 'Age'
    zstudent_hdr_gy.age as Age,
    @EndUserText.label: 'Course'
    zstudent_hdr_gy.course as Course,
    @EndUserText.label: 'Course Duration'
    zstudent_hdr_gy.courseduration as Courseduration,
    @EndUserText.label: 'Status'
    zstudent_hdr_gy.status as Status,
    @EndUserText.label: 'Gender'
    zstudent_hdr_gy.gender as Gender,
    @EndUserText.label: 'DOB'
    
    zstudent_hdr_gy.dob as Dob,
    zstudent_hdr_gy.lastchangedat as Lastchangedat,
    zstudent_hdr_gy.locallastchangedat as Locallastchangedat,
    
   _Attachments // Make association public 
   
    
}
