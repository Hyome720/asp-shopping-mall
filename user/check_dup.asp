<%
response.codepage = 949
response.charset = "EUC-KR"

Dim c_name
c_name = Request.Form("c_name")
    
Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=ShopDB; UID=sa; PWD=1234;")

if c_name <> "" then
    sql = "SELECT * FROM Game_Customer WHERE c_name = '" & c_name & "'"
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, db, 1

    if rs.EOF then
        Response.Write("<span style='color:green'>��� ������ ���̵��Դϴ�.</span>")
    else
        Response.Write("<span style='color:red'>�̹� ������� ���̵��Դϴ�.</span>")
    end if
end if
%>
