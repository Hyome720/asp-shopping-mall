<%
if Session("id") <> "admin" then
Response.Write("<script>alert('불법적인 경로로 진입하셨나요?');</script>")
Response.Write("<script>parent.location.reload();</script>")
end if

g_code = Request("code")

Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=ShopDB; UID=sa; PWD=1234;")

sql = "DELETE FROM Game_Goods WHERE g_code = '" & g_code & "'"
db.Execute(sql)

Response.Write("<script>alert('게시물이 삭제되었습니다.');</script>")
Response.Write("<script>parent.location.reload();</script>")

db.Close()
%>