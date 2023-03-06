<%
temp_g_code = Request("temp_g_code")
temp_ea = Request("temp_ea")


Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=ShopDB;UID=sa;PWD=1234;")

sql = "INSERT INTO Game_Temp_Buy (temp_c_code, temp_g_code, temp_ea) VALUES"
sql = sql & "('" & Session("code") & "'"
sql = sql & ",'" & temp_g_code & "'"
sql = sql & "," & temp_ea & ")"

db.Execute(sql)

Response.Redirect("game_cart.asp")
%>
