<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<%
g_code = Request("code")

Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=ShopDB;UID=sa;PWD=1234;")

sql = "DELETE FROM Game_Temp_Buy WHERE temp_c_code = '" & Session("id") & "'"

db.Execute(sql)
Response.Redirect("game_cart.asp")
%>