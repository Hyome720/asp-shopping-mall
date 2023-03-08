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

g_content = rs("g_content")
if g_content <> "" then
else
g_content = "등록된 정보가 없습니다."
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
            <div class="col-md-4 position-relative w-50">
                <img src="../img/<%=rs("g_img")%>" class="card-img-top position-absolute top-50 start-50 translate-middle w-75" alt="<%=rs("g_part")%>" onerror='this.src="../img/<%=rs("g_part")%>.jpg"'>
            </div>
            <div class="col-md-8 w-50">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <h5 class="card-title"><%=rs("g_name")%></h5>
                        <% if Session("id") = "admin" then %>
                        <button type="button" class="btn btn-outline-danger" onclick="location.href = 'game_content_del.asp?code=<%=g_code%>'">삭제하기</button>
                        <% end if %>
                    </div>
                    <hr>
                    제조사 : <%=rs("g_maker")%></h5>
                    <p class="red card-text mt-3 text-decoration-line-through">기존가 : <%=formatcurrency(rs("g_sell_price"))%></p>
                    <p class="card-text">판매가 : <%=formatcurrency(rs("g_ori_price"))%></p>
                    <p class="card-text">상세정보 : <%=g_content%></p>
                    
                    <p class="card-text"><small class="text-muted">등록일 : <%=rs("g_update_day")%></small></p>
                    <form name="order_form" method="post" action="game_buy_temp.asp">
                        <input type="hidden" name="temp_g_code" value="<%=g_code%>">
                        <label for="temp_ea">주문</label>
                        <input type="number" min="1" class="form-control mb-3" name="temp_ea" id="temp_ea" required>
                        <input type="submit" class="btn btn-outline-success" value="장바구니에 담기">
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>