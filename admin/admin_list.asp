<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<%
Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=ShopDB; UID=sa; PWD=1234;")

sql = "SELECT A.c_addr, A.c_tel, A.c_name, B.b_total_price, B.b_date,"
sql = sql & " B.b_bank, B.b_summary FROM Game_Customer A, Game_Buy B"
sql = sql & " WHERE A.c_code = B.c_code_ori ORDER BY b_date desc"

Set rs = Server.CreateObject("ADODB.RecordSet")
Set rs = db.Execute(sql)

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <title>Document</title>
</head>
<body>
    <table class="table table-dark table-striped">
        <tr>
            <th>구매자</th>
            <th>거래내역</th>
            <th>결제액</th>
            <th>입금은행</th>
            <th>구매일</th>
            <th>주소</th>
            <th>연락처</th>
        </tr>
        <% Do Until rs.EOF
        summary = replace(rs("b_summary"), chr(13) & chr(10), "<br>")
        %>
        <tr>
            <td><%=rs("c_name")%></td>
            <td><%=summary%></td>
            <td><%=formatcurrency(rs("b_total_price"))%></td>
            <td><%=rs("b_bank")%></td>
            <td><%=rs("b_date")%></td>
            <td><%=rs("c_addr")%></td>
            <td><%=rs("c_tel")%></td>
        </tr>
        <%
        rs.MoveNext
        Loop
        %>
    </table>
</body>
</html>