<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<%
if Session("id") = "" then
Response.Write("<script>alert('�α������ּ���!');</script>")
Response.Write("<script>parent.location.reload();</script>")
end if

Response.Expires = 0

Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=ShopDB;UID=sa;PWD=1234;")


sql = "SELECT temp_ea, temp_c_code, temp_g_code, g_name, g_code, g_sell_price FROM Game_Temp_Buy A, Game_Goods B"
sql = sql & " WHERE A.temp_c_code = '" & Session("id") & "'"
sql = sql & " AND A.temp_g_code = B.g_code"

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, db

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <title><%=session.SessionID%>���� ��ٱ���</title>
</head>
<body>
    <script>
        function cart_update() {
            document.order_form.action = "game_update.asp"
            document.order_form.submit()
        }
        function cart_reset() {
            document.order_form.action = "game_reset.asp"
            document.order_form.submit()
        }
        function cart_order() {
            document.order_form.action = "game_order.asp"
            document.order_form.submit()
        }
    </script>
    <% if rs.EOF then %>
    <p>��ٱ��Ͽ� �ƹ��͵� �����..</p>
    <% else %>
    <form method="POST" name="order_form">
        <input type="hidden" name="g_code" value="<%=rs("g_code")%>">
        <table class="table table-striped">
            <tr>
                <th>��ǰ��</th>
                <th>����</th>
                <th>����</th>
                <th>����</th>
            </tr>
            <% Do Until rs.EOF %>
            <tr>
                <td>
                    <a href="game_content?code=<%=rs("g_code")%>">
                        <%=rs("g_name")%>
                    </a>
                </td>
                <td>
                    <input type="number" min="1" class="form-control mb-3" value="<%=rs("temp_ea")%>" name="temp_ea" required>
                </td>
                <td>
                    <%=formatcurrency(rs("g_sell_price") * rs("temp_ea"))%>
                </td>
                <td>
                    <a href="game_del.asp?code=<%=rs("g_code")%>">X</a>
                </td>
            </tr>

            <%
            total_price = total_price + (rs("g_sell_price") * rs("temp_ea"))
            rs.MoveNext
            loop
            %>
            <tr>
                <td>
                </td>
                <td>
                <button type="button" class="btn btn-warning" onclick="cart_update()">������Ʈ</button>
                <button type="button" class="btn btn-secondary" onclick="cart_reset()">��ٱ��� ����</button>
                <button type="button" class="btn btn-primary" onclick="cart_order()">�ֹ��ϱ�</button>
                </td>
                <td>
                    �հ� : <%=formatcurrency(total_price)%>
                    <input type="hidden" name="total_price" value="<%=total_price%>">
                <td>
                <td>
                </td>
            </tr>
            <% end if %>
        </table>
    </form>
</body>
</html>