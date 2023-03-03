<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<%
part = Request("part")

Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=ShopDB;UID=sa;PWD=1234;")

sql = "SELECT g_code, g_part, g_name, g_maker, g_sell_price, g_img,"
sql = sql & "g_update_day FROM Game_Goods"
sql = sql & " WHERE g_part = '" & part & "' ORDER BY g_update_day DESC"

Set rs = Server.CreateObject("ADODB.Recordset")

rs.Open sql, db, 1
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <title><%=part%> 둘러보기</title>
</head>
<body>
    <% if rs.EOF then %>
    <p>데이터가 없습니다 ㅠㅠ</p>
    <% else %>
    <div class="d-flex flex-wrap justify-content-between">
        <% Do Until rs.EOF %>
        <div class="card mb-3" style="width: 18rem;">
            <img src="..." class="card-img-top image-fluid" alt="<%=part%>" onerror="this.src='../img/<%=part%>.jpg'">
            <div class="card-body text-center">
                <h5 class="card-title"><%=rs("g_name")%>
                <hr>
                제조사 : <%=rs("g_maker")%>
                </h5>
                <p class="card-text pt-2">가격 : <%=formatcurrency(rs("g_sell_price"))%></p>
                <p class="card-text">등록일 : <%=rs("g_update_day")%></p>
                <div class="d-flex justify-content-between mx-5">
                    <a href="game_content.asp?code=<%=rs("g_code")%>" class="btn btn-primary">상세정보</a>
                    <a href="#" class="btn btn-primary">담기</a>
                </div>
            </div>
        </div>
        <% rs.MoveNext
        loop
        end if 
        %>
    </div>
</body>
</html>