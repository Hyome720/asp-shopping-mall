<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <title>게임 쇼핑몰</title>
</head>
<body>
    <div>
        <p><a href="../game/game_list.asp">장바구니</a></p>

        <p><a href="game/game_list.asp?part=game">게임</a></p>
        <p><a href="../game/game_list.asp?part=console">게임기</a></p>
        <p><a href="../game/game_list.asp?part=movie">영화</a></p>

        <% if session("id") <> "admin" then %>
        <p><a href="../admin/admin_login.asp">관리자 로그인</a></p>
        <% else %>
        <p><a href="../admin/admin_main.asp">관리자 메뉴</a></p>
        <% end if %>
    </div>
</body>
</html>