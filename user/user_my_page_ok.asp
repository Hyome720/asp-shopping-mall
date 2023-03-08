<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<%
c_name = Request("c_name")
c_postcode = Request("c_postcode")
c_address = Request("c_address")
c_detailAddress = Request("c_detailAddress")
c_extraAddress = Request("c_extraAddress")
c_tel = Request("c_tel")
c_pwd = Request("c_pwd")
c_addr = c_address & c_extraAddress & " " & c_detailAddress

Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=ShopDB; UID=sa; PWD=1234;")

sql = "SELECT c_pwd FROM Game_Customer WHERE c_code = '" & Session("id") & "'"

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, db, 1

if rs("c_pwd") <> c_pwd then
    Response.Write ("<script>alert('비밀번호가 틀렸대요~');history.back();</script>")
else
    sql = "UPDATE Game_Customer SET"
    sql = sql & " c_name = '" & c_name & "'"
    sql = sql & ", c_addr = '" & c_addr & "'"
    sql = sql & ", c_tel = '" & c_tel & "'"
    sql = sql & ", c_postcode = '" & c_postcode & "'"
    sql = sql & ", c_address = '" & c_address & "'"
    sql = sql & ", c_detailAddress = '" & c_detailAddress & "'"
    sql = sql & ", c_extraAddress = '" & c_extraAddress & "'"
    sql = sql & " WHERE c_code = '" & Session("id") & "'"

    db.Execute(sql)

    db.Close()

    Response.Write("<script>alert('정보가 업데이트 되었습니다.');</script>")
    Response.Write("<script>parent.location.reload();</script>")
end if
%>