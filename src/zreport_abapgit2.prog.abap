*&---------------------------------------------------------------------*
*& Report ZREPORT_ABAPGIT2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZREPORT_ABAPGIT2.

*Table Declaration
TABLES: vbap.

*Type Declaration
TYPES : BEGIN OF ty_vbap,

vbeln TYPE vbap-vbeln,
posnr TYPE vbap-posnr,
matnr TYPE vbap-matnr,
matkl TYPE vbap-matkl,
arktx TYPE vbap-arktx,
netwr TYPE vbap-netwr,
waerk TYPE vbap-waerk,
klmeng TYPE vbap-klmeng,
vrkme TYPE vbap-vrkme,

END OF ty_vbap.

*Data Declaration
DATA : lt_vbap TYPE STANDARD TABLE OF ty_vbap,
ls_vbap TYPE ty_vbap.

DATA : lt_fieldcat TYPE slis_t_fieldcat_alv,
ls_fieldcat TYPE slis_fieldcat_alv,
v_repid LIKE sy-repid.

*Selection Screen
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-002.
SELECT-OPTIONS: so_vbeln FOR vbap-vbeln,
so_matnr FOR vbap-matnr.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.

*Data Fetching
SELECT vbeln

posnr
matnr
matkl
arktx
netwr
waerk
*kimeng
*vrkme

FROM vbap INTO TABLE lt_vbap
WHERE vbeln IN so_vbeln AND matnr IN so_matnr.

*Field Catalog
CLEAR ls_fieldcat.
ls_fieldcat-col_pos = 1.
ls_fieldcat-fieldname = 'VBELN'.
ls_fieldcat-tabname = 'IT_VBAP'.
ls_fieldcat-seltext_m = 'SD NO.'.
ls_fieldcat-key = 'X'.
APPEND ls_fieldcat TO lt_fieldcat.

CLEAR ls_fieldcat.
ls_fieldcat-col_pos = 2.
ls_fieldcat-fieldname = 'POSNR'.
ls_fieldcat-tabname = 'IT_VBAP'.
ls_fieldcat-seltext_m = 'ITEM NO.'.
APPEND ls_fieldcat TO lt_fieldcat.

CLEAR ls_fieldcat.
ls_fieldcat-col_pos = 3.
ls_fieldcat-fieldname = 'MATNR'.
ls_fieldcat-tabname = 'IT_VBAP'.
ls_fieldcat-seltext_m = 'MATERIAL NO.'.
APPEND ls_fieldcat TO lt_fieldcat.

CLEAR ls_fieldcat.
ls_fieldcat-col_pos = 4.
ls_fieldcat-fieldname = 'MATKL'.
ls_fieldcat-tabname = 'IT_VBAP'.
ls_fieldcat-seltext_m = 'MATERIAL GROUP'.
APPEND ls_fieldcat TO lt_fieldcat.

CLEAR ls_fieldcat.
ls_fieldcat-col_pos = 5.
ls_fieldcat-fieldname = 'ARKTX'.
ls_fieldcat-tabname = 'IT_VBAP'.
ls_fieldcat-seltext_m = 'DESCRIPTION'.
APPEND ls_fieldcat TO lt_fieldcat.

CLEAR ls_fieldcat.
ls_fieldcat-col_pos = 6.
ls_fieldcat-fieldname = 'NETWR'.
ls_fieldcat-tabname = 'IT_VBAP'.
ls_fieldcat-seltext_m = 'AMOUNT'.
APPEND ls_fieldcat TO lt_fieldcat.

CLEAR ls_fieldcat.
ls_fieldcat-col_pos = 7.
ls_fieldcat-fieldname = 'WAERK'.
ls_fieldcat-tabname = 'IT_VBAP'.
ls_fieldcat-seltext_m = 'CURRENCY'.
APPEND ls_fieldcat TO lt_fieldcat.

*CLEAR ls_fieldcat.
*ls_fieldcat-col_pos = 8.
*ls_fieldcat-fieldname = 'KLMENG'.
*ls_fieldcat-tabname = 'IT_VBAP'.
*ls_fieldcat-seltext_m = 'QUANTITY'.
*APPEND ls_fieldcat TO lt_fieldcat.

*CLEAR ls_fieldcat.
*ls_fieldcat-col_pos = 9.
*ls_fieldcat-fieldname = 'VRKME'.
*ls_fieldcat-tabname = 'IT_VBAP'.
*ls_fieldcat-seltext_m = 'SALES UNIT'.
*APPEND ls_fieldcat TO lt_fieldcat.

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
EXPORTING
i_callback_program = sy-repid
it_fieldcat = lt_fieldcat
TABLES
t_outtab = lt_vbap
EXCEPTIONS
program_error = 1
OTHERS = 2.

IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
