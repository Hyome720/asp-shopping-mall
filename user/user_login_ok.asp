<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<%
c_name = Request("c_name")
c_pwd = Request("c_pwd")

Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=ShopDB;UID=sa;PWD=1234;")

sql = "SELECT c_name, c_code FROM Game_Customer WHERE" 
sql = sql & " c_name = '" & c_name & "'"
sql = sql & " AND c_pwd = '" & c_pwd & "'"

Set rs = db.Execute(sql) 

if rs.EOF or rs.BOF then
    Response.Write("<script>alert('���̵� �Ǵ� ��й�ȣ�� Ʋ�Ƚ��ϴ�');history.back();</script>")
else
    Session("id") = rs("c_code")
    Session("name") = rs("c_name")
    Response.Write("<script>alert('�α��� �Ǿ����ϴ�.');</script>")
    Response.Redirect("../game/game_list.asp")
end if
%>
