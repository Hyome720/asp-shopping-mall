<%
temp_g_code = Request("temp_g_code")
temp_ea = Request("temp_ea")


Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=ShopDB;UID=sa;PWD=1234;")

' ��ٱ��� �ߺ� ��ǰ �˻�
sql = "SELECT * FROM Game_Temp_Buy WHERE temp_g_code = '" & temp_g_code & "'"
sql = sql & " AND temp_c_code = '" & Session("id") & "'"

Set rs = db.Execute(sql)

' ���ο� ��ǰ�� ��� �׸� �߰�
If rs.EOF or rs.BOF then
    sql = "INSERT INTO Game_Temp_Buy (temp_c_code, temp_g_code, temp_ea) VALUES"
    sql = sql & "('" & Session("id") & "'"
    sql = sql & ",'" & temp_g_code & "'"
    sql = sql & "," & temp_ea & ")"

    db.Execute(sql)

' �ƴ� ��� ���� �׸� �߰�
Else
    sql = "UPDATE Game_Temp_Buy SET"
    sql = sql & " temp_ea = temp_ea + " & temp_ea
    sql = sql & " WHERE temp_g_code = '" & temp_g_code & "'" 

    db.Execute(sql)

End if

Response.Redirect("game_cart.asp")
%>
