<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<%
c_name = Request("c_name")
c_pwd = Request("c_pwd")
c_addr = Request("c_addr")
c_tel = Request("c_tel")

Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=ShopDB;UID=sa;PWD=1234;")

sql = "INSERT INTO Game_Customer (c_name, c_pwd, c_tel, c_addr) VALUES ("
sql = sql & "'" & c_name & "'"
sql = sql & ",'" & c_pwd & "'"
sql = sql & ",'" & c_tel & "'"
sql = sql & ",'" & c_addr & "')"

db.Execute(sql)

sql_session = "SELECT c_code, c_name FROM Game_Customer WHERE c_name = '" & c_name & "'"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql_session, db

rs.Close()
db.Close()

Response.Redirect("../game/game_list.asp?msg=success")
%>
