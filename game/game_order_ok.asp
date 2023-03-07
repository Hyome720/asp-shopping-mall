<!--#include file="pkval.asp" -->
<%
total_price = Request("total_price")
c_name = Request("c_name")
c_addr = Request("c_addr")
c_tel = Request("c_tel")
bank_acc = Request("bank_acc")
order_time = now()

Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=ShopDB; UID=sa; PWD=1234;")

sql = "SELECT temp_ea, g_code, g_name, g_sell_price FROM Game_Temp_Buy A, Game_Goods B"
sql = sql & " WHERE A.temp_c_code = '" & Session("id") & "'"
sql = sql & " AND A.temp_g_code = B.g_code"

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, db

Do Until rs.EOF
    price = rs("g_sell_price")
    ea = rs("temp_ea")
    code = rs("g_code")
    g_name = rs("g_name")
    str = g_name & "(" & code & ") :" & ea & "°³" & chr(13) & chr(10)
    summary = summary & str

    rs.MoveNext
loop

rs.Close()

sql = "INSERT INTO Game_Buy (b_code, c_code, b_date, b_summary, b_total_price, b_bank, c_code_ori) VALUES"
sql = sql & " ('" & primaryval & Session("id") & "'"
sql = sql & ",'" & primaryval & Session("id") & "'"
sql = sql & ",'" & order_time & "'"
sql = sql & ",'" & summary & "'"
sql = sql & "," & total_price
sql = sql & ",'" & bank_acc & "'"
sql = sql & ",'" & Session("id") & "')"
db.Execute(sql)

sql = "DELETE FROM Game_Temp_Buy WHERE temp_c_code = '" & Session("id") & "'"
db.Execute(sql)

Response.Redirect "game_result.asp"
%>