<%
if Session("id") <> "admin" then
Response.Write("<script>alert('�ҹ����� ��η� �����ϼ̳���?');</script>")
Response.Write("<script>parent.location.reload();</script>")
end if

g_code = Request("code")

Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=ShopDB; UID=sa; PWD=1234;")

sql = "DELETE FROM Game_Goods WHERE g_code = '" & g_code & "'"
db.Execute(sql)

Response.Write("<script>alert('�Խù��� �����Ǿ����ϴ�.');</script>")
Response.Write("<script>parent.location.reload();</script>")

db.Close()
%>