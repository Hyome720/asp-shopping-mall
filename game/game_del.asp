<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<%
g_code = Request("code")

Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=ShopDB;UID=sa;PWD=1234;")

sql = "DELETE FROM Game_Temp_Buy WHERE temp_c_code = '" & session.SessionID & "'"
sql = sql & " AND temp_g_code = '" & g_code & "'"

db.Execute(sql)
Response.Redirect("game_cart.asp")
%>