<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<%
c_name = Request("c_name")
c_pwd = Request("c_pwd")

Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=ShopDB;UID=sa;PWD=1234;")

sql = "SELECT c_name FROM Game_Admin WHERE" 
sql = sql & " c_name = '" & c_name & "'"
sql = sql & " AND c_pwd = '" & c_pwd & "'"

Set rs = db.Execute(sql) 

if rs.EOF or rs.BOF then
    Response.Write("<script>alert('아이디 또는 비밀번호가 틀렸습니다');history.back();</script>")
else
    Session("id") = rs("c_name")
    Session("name") = "관리자"
    Response.Write("<script>alert('관리자 로그인 되었습니다.');</script>")
    Response.Write("<script>parent.location.reload();</script>")
end if
%>
