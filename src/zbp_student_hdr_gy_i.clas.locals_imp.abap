CLASS lhc_Student DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PUBLIC SECTION.
*  methods get
    " for query
*  importing value(request) type ref to /iwbep/if_mgw_odata_model
*  exporting value(response) type ref to /iwbep/if_mgw_odata_model.

  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Student RESULT result.
    METHODS statusUpdate FOR MODIFY
      IMPORTING keys FOR ACTION Student~statusUpdate.
    METHODS copyStudent FOR MODIFY
      IMPORTING keys FOR ACTION Student~copyStudent.
    METHODS createInstance FOR MODIFY
      IMPORTING keys FOR ACTION Student~createInstance.

ENDCLASS.

CLASS lhc_Student IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD statusUpdate.

    " kayıtları okuma:

    READ ENTITIES OF zstudent_hdr_gy_i IN LOCAL MODE
    ENTITY Student
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_students)
    FAILED failed.

    "sıralama:
    SORT lt_students BY Status DESCENDING.

    "itab'de loop ile dönüp alan güncellenir
    LOOP AT lt_students ASSIGNING FIELD-SYMBOL(<lfs_students>).

      IF <lfs_students>-Age < 25.

        APPEND VALUE #( %tky = <lfs_students>-%tky ) TO failed-student.
        APPEND VALUE #( %tky = <lfs_students>-%tky
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = <lfs_students>-Firstname && 'in yaşı 25 den az olduğundan durum güncellenmedi' )
                        ) TO reported-student.

      ELSE.

        <lfs_students>-Status = abap_true.
      ENDIF.
    ENDLOOP.

    "güncellenen alan entityde modify edilir.

    IF  failed-student IS INITIAL.

      SORT lt_students BY Status DESCENDING.

      MODIFY ENTITIES OF zstudent_hdr_gy_i IN LOCAL MODE
      ENTITY Student
      UPDATE FIELDS ( Status ) WITH CORRESPONDING #( lt_students ).
    ENDIF.
  ENDMETHOD.

  METHOD copyStudent.

* internal table tanımlanıyor:
    DATA: lt_student TYPE TABLE FOR CREATE zstudent_hdr_gy_i.

*frontenddeki seçili data okunuyor:
    READ ENTITIES OF zstudent_hdr_gy_i IN LOCAL MODE
    ENTITY Student
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(students)
    FAILED failed.

    LOOP AT students ASSIGNING FIELD-SYMBOL(<lfs_students>).
*    id key field olduğu için o kopyalanmıyor
      APPEND VALUE #( %cid = keys[ KEY entity %key = <lfs_students>-%key ]-%cid
                      %is_draft = keys[ KEY entity %key = <lfs_students>-%key ]-%param-%is_draft
                      %data = CORRESPONDING #( <lfs_students> EXCEPT id )
                       ) TO lt_student ASSIGNING FIELD-SYMBOL(<lfs_newStudent>).
    ENDLOOP.

    "create business object instance by copy
    MODIFY ENTITIES OF zstudent_hdr_gy_i IN LOCAL MODE
    ENTITY Student
    CREATE FIELDS ( Firstname Lastname Age Course Courseduration Status Gender Dob )
    WITH lt_student
    MAPPED DATA(mapped_create).

    "oluşturulan mapped_create frontend tarafındaki mapped-student'a gönderilir:
    mapped-student = mapped_create-student.

  ENDMETHOD.

  METHOD createInstance.

    MODIFY ENTITIES OF zstudent_hdr_gy_i IN LOCAL MODE
    ENTITY Student
    CREATE FROM VALUE #( FOR <instance> IN keys ( %cid           = <instance>-%cid
                                                  Age            = 1
                                                  Course         = 'C1'
                                                  Courseduration = 1
                                                  Firstname      = 'FN'
                                                  Lastname       = 'LN'
                                                  Dob            = sy-datum
                                                  %control       =
                                                  VALUE #(
                                                  Age            = if_abap_behv=>mk-on
                                                  Course         = if_abap_behv=>mk-on
                                                  Courseduration = if_abap_behv=>mk-off
                                                  Firstname      = if_abap_behv=>mk-on
                                                  Lastname       = if_abap_behv=>mk-on
                                                  Dob            = if_abap_behv=>mk-on ) )
                       ) MAPPED mapped
                         FAILED failed
                         REPORTED reported.

  ENDMETHOD.

ENDCLASS.
