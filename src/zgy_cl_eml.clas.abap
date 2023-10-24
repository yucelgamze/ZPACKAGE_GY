CLASS zgy_cl_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zgy_cl_eml IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA: it_student_create TYPE TABLE FOR CREATE zstudent_hdr_gy_i,
          it_student_update TYPE TABLE FOR UPDATE zstudent_hdr_gy_i,
          it_student_delete TYPE TABLE FOR UPDATE zstudent_hdr_gy_i,
          op_table          TYPE abp_behv_changes_tab,
          lt_failed         TYPE abp_behv_response_tab,
          lt_reported       TYPE abp_behv_response_tab,
          lt_mapped         TYPE abp_behv_response_tab.

    it_student_create  = VALUE #( ( %cid = 'StudentHead' Firstname = 'Dynamic' Lastname = 'Modify'
                            Age = 55  Course = 'Electronics' Courseduration = 9 Status = ''
                            %control = VALUE #( Firstname = if_abap_behv=>mk-on
                                                Lastname  = if_abap_behv=>mk-on
                                                Age = if_abap_behv=>mk-on
                                                Course = if_abap_behv=>mk-on
                                                Courseduration = if_abap_behv=>mk-off
                                                Status =  if_abap_behv=>mk-on )
                             ) ).
    it_student_update = VALUE #( ( %cid_ref = 'StudentHead' Status = 'X' %control-Status = if_abap_behv=>mk-on ) ).
    it_student_delete = VALUE #( ( %tky-Id  = '1A29E908CA671EEE9CA37D2FDCD75C75' ) ).


    op_table = VALUE #(
    ( op = if_abap_behv=>op-m-create
      entity_name = 'ZSTUDENT_HDR_GY_I'
      instances = REF #( it_student_create ) )
    ( op = if_abap_behv=>op-m-update
      entity_name = 'ZSTUDENT_HDR_GY_I'
      instances = REF #( it_student_update )  )
    ( op = if_abap_behv=>op-m-delete
      entity_name = 'ZSTUDENT_HDR_GY_I'
      instances = REF #( it_student_delete )  ) ).

    MODIFY ENTITIES OPERATIONS op_table
    FAILED lt_failed
    REPORTED lt_reported
    MAPPED lt_mapped.

    COMMIT ENTITIES.





*  EML

*internal table root data definitondan  (interface) tanımlanıyor
*    DATA: it_student TYPE TABLE FOR CREATE zstudent_hdr_gy_i.
*
*    it_student = VALUE #( ( Firstname = 'FirstName' Lastname = 'Last Name'
*                            Age = 55  Course = 'Electronics' Courseduration = 9 Status = ''
*                            %control = VALUE #( Firstname = if_abap_behv=>mk-on
*                                                Lastname  = if_abap_behv=>mk-on
*                                                Age = if_abap_behv=>mk-on
*                                                Course = if_abap_behv=>mk-on
*                                                Courseduration = if_abap_behv=>mk-off
*                                                Status =  if_abap_behv=>mk-on )
*                             ) ).
*
*    MODIFY ENTITIES OF zstudent_hdr_gy_i
*    ENTITY Student
*    CREATE FROM it_student
*    MAPPED DATA(lt_mapped)
*    FAILED DATA(lt_failed)
*    REPORTED DATA(lt_reported).
*
*    IF lt_failed IS NOT INITIAL.
*      out->write(
*        EXPORTING
*          data   = lt_failed
*          name   = 'FAILED'
**          RECEIVING
**            output =
*      ).
*    ELSE.
*      COMMIT ENTITIES.
*
*      SELECT FROM zstudent_hdr_gy
*      FIELDS id, firstname, lastname, age, course, courseduration, status
*      ORDER BY id
*      INTO TABLE @DATA(lt_out).
*      IF sy-subrc IS INITIAL.
*        out->write(
*          EXPORTING
*            data   = lt_out
**            name   =
**          RECEIVING
**            output =
*        ).
*      ENDIF.
*    ENDIF.

*EML CREATE BY ASSOCIATION

*operation for read entity

*    DATA: lv_operation TYPE char3 VALUE 'RES'.
*    CASE lv_operation.
*
**    create
*      WHEN 'C'.
*
**         hem header hem de child için internal table oluşturulur:
*
*        DATA: lt_student TYPE TABLE FOR CREATE zstudent_hdr_gy_i.
*        DATA: lt_attachments TYPE TABLE FOR CREATE zstudent_hdr_gy_i\_Attachments,
*              ls_attachments LIKE LINE OF lt_attachments.
*
*        DATA: lt_target LIKE ls_attachments-%target.
*
*        lt_student = VALUE #( ( %cid = 'StudentHeader' Firstname = 'FirstName' Lastname = 'Last Name'
*                        Age = 55  Course = 'Electronics' Courseduration = 9 Status = ''
*                        %control = VALUE #( Firstname = if_abap_behv=>mk-on
*                                            Lastname  = if_abap_behv=>mk-on
*                                            Age = if_abap_behv=>mk-on
*                                            Course = if_abap_behv=>mk-on
*                                            Courseduration = if_abap_behv=>mk-off
*                                            Status =  if_abap_behv=>mk-on )
*                         ) ).
**           attachment için data oluşturulur:
*
*        lt_target = VALUE #( ( %cid = 'StudentAttachments' AttachId = 10 Comments = 'Dosya eki için test yorumu' Filename = 'test dosya adı'
*                               %control = VALUE #( AttachId = if_abap_behv=>mk-on
*                                                   Comments = if_abap_behv=>mk-on
*                                                   Filename = if_abap_behv=>mk-on
*                            ) ) ).
*
*        lt_attachments = VALUE #( ( %cid_ref = 'StudentHeader' %target = lt_target ) ).
*
**         data kaydedilir:
*        MODIFY ENTITIES OF zstudent_hdr_gy_i
*        ENTITY Student
*        CREATE FROM lt_student
*        CREATE BY \_Attachments FROM lt_attachments
*        MAPPED DATA(lt_mapped)
*        FAILED DATA(lt_failed)
*        REPORTED DATA(lt_reported).
*
*        IF lt_failed IS INITIAL.
*          COMMIT ENTITIES.
*          out->write(
*            EXPORTING
*              data   = 'Record Created with Association'
**                   name   =
**                 RECEIVING
**                   output =
*          ).
*        ENDIF.
** read entity
*      WHEN 'RE'.
*
*        READ ENTITY zstudent_hdr_gy_i
*        FROM VALUE #( ( %tky-Id  = '8A8A91DA98E91EDE988BBF9072BD7928'
*                        %control = VALUE #( Course = if_abap_behv=>mk-on Courseduration = if_abap_behv=>mk-on ) ) )
*                        RESULT DATA(lt_result)
*                        FAILED lt_failed
*                        REPORTED lt_reported.
*
*        out->write(
*          EXPORTING
*            data   = lt_result
**             name   =
**           RECEIVING
**             output =
*        ).
*
**        read entities for multiple records
*      WHEN 'RES'.
*
*        READ ENTITIES OF zstudent_hdr_gy_i
*        ENTITY Student
*        ALL FIELDS WITH VALUE #( ( %tky-Id = '8A8A91DA98E91EDE988BBF9072BD7928' ) )
*        RESULT lt_result
*
*        ENTITY Student
*        BY \_Attachments
*        ALL FIELDS WITH VALUE #( ( %tky-Id = '8A8A91DA98E91EDE988BBF9072BD7928' ) )
*        RESULT DATA(lt_result2)
*
*        FAILED lt_failed
*        REPORTED lt_reported.
*
*        out->write(
*          EXPORTING
*            data   = lt_result
**            name   =
**          RECEIVING
**            output =
*        ).
*
*        out->write(
*          EXPORTING
*            data   = lt_result2
**            name   =
**          RECEIVING
**            output =
*        ).
*
*        READ ENTITIES OF zstudent_hdr_gy_i
*        ENTITY Student BY \_Attachments
*        ALL FIELDS WITH VALUE #( ( %tky-Id = '8A8A91DA98E91EDE988BBF9072BD7928' ) )
*        RESULT DATA(lt_result3)
*        LINK DATA(lt_link)
*
*        FAILED lt_failed
*        REPORTED lt_reported.
*
*        out->write(
*          EXPORTING
*            data   = lt_result3
**            name   =
**          RECEIVING
**            output =
*        ).
*
*    ENDCASE.

  ENDMETHOD.

ENDCLASS.
