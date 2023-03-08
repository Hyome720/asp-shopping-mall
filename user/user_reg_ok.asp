<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<%
c_name = Request("c_name")
c_pwd = Request("c_pwd")
c_postcode = Request("c_postcode")
c_address = Request("c_address")
c_detailAddress = Request("c_detailAddress")
c_extraAddress = Request("c_extraAddress")
c_addr = c_address & c_extraAddress & " " & c_detailAddress
c_tel = Request("c_tel")

Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=ShopDB;UID=sa;PWD=1234;")

sql = "INSERT INTO Game_Customer (c_name, c_pwd, c_tel, c_postcode, c_addr, c_address, c_detailAddress, c_extraAddress) VALUES ("
sql = sql & "'" & c_name & "'"
sql = sql & ",'" & c_pwd & "'"
sql = sql & ",'" & c_tel & "'"
sql = sql & ",'" & c_postcode & "'"
sql = sql & ",'" & c_addr & "'"
sql = sql & ",'" & c_address & "'"
sql = sql & ",'" & c_detailAddress & "'"
sql = sql & ",'" & c_extraAddress & "')"

db.Execute(sql)

sql_session = "SELECT c_code, c_name FROM Game_Customer WHERE c_name = '" & c_name & "'"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql_session, db

rs.Close()
db.Close()

Response.Redirect("../game/game_list.asp?msg=success")
%>
