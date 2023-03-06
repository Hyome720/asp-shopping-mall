<%
num = Request("g_code").count
Response.Write num

Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=ShopDB; UID=sa; PWD=1234;")

for i = 1 to num

sql = "UPDATE Game_Temp_Buy SET"
sql = sql & " temp_ea = " & Request("temp_ea")(i)
sql = sql & " WHERE temp_c_code = '" & Session("id") & "'"
sql = sql & " AND temp_g_code = '" & Request("g_code")(i) & "'"

db.Execute(sql)

Next

Response.Redirect "./game_cart.asp"

%>