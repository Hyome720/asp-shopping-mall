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
    Response.Write("<script>alert('���̵� �Ǵ� ��й�ȣ�� Ʋ�Ƚ��ϴ�');history.back();</script>")
else
    Session("id") = rs("c_name")
    Session("name") = "������"
    Response.Write("<script>alert('������ �α��� �Ǿ����ϴ�.');</script>")
    Response.Write("<script>parent.location.reload();</script>")
end if
%>
