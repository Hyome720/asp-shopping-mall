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

if part <> "" then
    sql = sql & " WHERE g_part = '" & part & "'"
end if

g_filter = Request.QueryString("g_filter")
if g_filter = "1" then
    sql = sql & " ORDER BY g_update_day DESC" 
elseif g_filter = "2" then
    sql = sql & " ORDER BY g_update_day ASC"
elseif g_filter = "3" then
    sql = sql & " ORDER BY g_sell_price DESC"
elseif g_filter = "4" then
    sql = sql & " ORDER BY g_sell_price ASC"
elseif g_filter = "5" then
    sql = sql & " ORDER BY g_name DESC"
else
    sql = sql & " ORDER BY g_name ASC"
end if


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
    <script>
        document.getElementById("filter_<%=g_filter%>").selected = true;
    </script>
    <%
    msg = Request("msg")
    if msg = "success" then
    %>
    <script>
    alert("회원가입이 완료되었습니다.");
    </script>
    <%
    end if
    %>
    <% if rs.EOF then %>
    <p>데이터가 없습니다 ㅠㅠ</p>
    <% else %>
    <form method="GET">
        <div class="position-relative">
            <select class="form-select position-absolute end-0 w-25 me-3" name="g_filter" aria-label="Default select example" onchange="this.form.submit()">
                <option id="filter_1" value="1" <% If g_filter = "1" Then Response.Write("selected") End If %>>등록일 내림차순</option>
                <option id="filter_2" value="2" <% If g_filter = "2" Then Response.Write("selected") End If %>>등록일 오름차순</option>
                <option id="filter_3" value="3" <% If g_filter = "3" Then Response.Write("selected") End If %>>높은 가격순</option>
                <option id="filter_4" value="4" <% If g_filter = "4" Then Response.Write("selected") End If %>>낮은 가격순</option>
                <option id="filter_5" value="5" <% If g_filter = "5" Then Response.Write("selected") End If %>>이름 내림차순</option>
                <option id="filter_6" value="6" <% If g_filter = "6" Then Response.Write("selected") End If %>>이름 오름차순</option>
            </select>
            <input type="hidden" name="part" value="<%=part%>">
        </div>
    </form>

    <div class="d-flex flex-wrap justify-content-between pt-5">
        <% Do Until rs.EOF %>
        <div class="card mb-3" style="width: 18rem;">
            <img src="../img/<%=rs("g_img")%>" class="card-img-top image-fluid w-100" alt="이미지가 없습니다" onerror="this.src='../img/<%=rs("g_part")%>.jpg'">
            <div class="card-body text-center">
                <h5 class="card-title"><%=rs("g_name")%>
                <hr>
                제조사 : <%=rs("g_maker")%>
                </h5>
                <p class="card-text pt-2">가격 : <%=formatcurrency(rs("g_sell_price"))%></p>
                <p class="card-text">등록일 : <%=rs("g_update_day")%></p>
                <div class="m-auto">
                    <a href="game_content.asp?code=<%=rs("g_code")%>" class="btn btn-primary">상세정보</a>
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