<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<%
g_code = Request("code")

Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=ShopDB;UID=sa;PWD=1234;")

sql = "SELECT * FROM Game_Goods WHERE g_code = '" & g_code & "'"

Set rs = db.Execute(sql)

if isEmpty(rs("g_content")) or isNull(rs("g_content")) then
g_content = Null
else
g_content = replace(rs("g_content"), chr(13), "<br>")
end if

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <title><%=rs("g_name")%> 상세보기</title>
</head>
<body>
    <div class="card mb-3">
        <div class="row g-0">
            <div class="col-md-4">
                <img src="..." class="card-img-top" alt="<%=rs("g_part")%>" onerror="this.src='../img/<%=rs("g_part")%>.jpg'">
            </div>
            <div class="col-md-8">
                <div class="card-body">
                    <h5 class="card-title"><%=rs("g_name")%>
                    <hr>
                    제조사 : <%=rs("g_maker")%></h5>
                    <p class="red card-text mt-3 text-decoration-line-through">기존가 : <%=formatcurrency(rs("g_ori_price"))%></p>
                    <p class="card-text">판매가 : <%=formatcurrency(rs("g_sell_price"))%></p>
                    <% if isNull(g_content) or isEmpty(g_content) then %>
                    <p class="card-text">상세 정보가 없습니다.</p>
                    <% else %>
                    <p class="card-text"><%=g_content%></p>
                    <% end if %>
                    
                    <p class="card-text"><small class="text-muted">등록일 : <%=rs("g_update_day")%></small></p>
                    <form name="order_form" method="post" action="game_buy_temp.asp">
                        <input type="hidden" name="temp_g_code" value="<%=g_code%>">
                        <label for="temp_ea">주문</label>
                        <input type="number" min="1" class="form-control mb-3" name="temp_ea" id="temp_ea" required>
                        <input type="submit" class="btn btn-outline-success" value="주문하기">
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>