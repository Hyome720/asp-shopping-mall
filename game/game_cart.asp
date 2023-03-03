<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<%
Response.Expires = 0

Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=ShopDB;UID=sa;PWD=1234;")

sql = "SELECT temp_ea, g_code, g_name, g_sell_price FROM Game_Temp_Buy A, Game_Goods B"
sql = sql & " WHERE A.temp_c_code = '" & session.SessionID & "'"
sql = sql & " AND A.temp_g_code = B.g_code"

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, db, 1

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <title><%=session.SessionID%>님의 장바구니</title>
</head>
<body>
    <% if rs.EOF then %>
    <p>장바구니에 아무것도 없어요..</p>
    <% else %>
    <form method="POST" name="order_form">
        <input type="hidden" name="g_code" value="<%=rs("g_code")%>">
        <table class="table table-striped">
            <tr>
                <th>제품명</th>
                <th>수량</th>
                <th>가격</th>
                <th>취소</th>
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
                    <a href="game_del.asp?code=<%rs("g_code")%>">X</a>
                </td>
            </tr>

            <%
            total_price = total_price + (rs("g_sell_price") * rs("temp_ea"))
            rs.MoveNext
            loop
            %>
            <tr>
                <td class="text-end">
                    <%=total_price%>
                <td>
            </tr>
            <% end if %>
        </table>
    </form>
</body>
</html>