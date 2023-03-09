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
    <title>���� ���θ�</title>
    
</head>
<body class="pt-5 p-0 mx-5" style="height: 100vh;">
    <script>
        function changeFrameSrc(src) {
            const iframe = document.getElementById("my_frame")
            iframe.src = src
        }
        function logout() {
            $.ajax({
                url: "user/user_logout.asp",
                success: function() {
                    // Reload the page to update the UI
                    location.reload();
                },
                error: function() {
                    alert("Failed to reset session.");
                }
            });
        }
    </script>
    <% if Session("id") = "" then %>
        <div class="d-flex justify-content-end">
            <button type="button" class="btn btn-secondary me-3" onclick="changeFrameSrc('user/user_reg.asp')">ȸ������</button>
            <button type="button" class="btn btn-secondary" onclick="changeFrameSrc('user/user_login.asp')">�α���</button>
        </div>
    <% else %>
        <div class="d-flex justify-content-between">
            <p><%=Session("name")%> �� �ȳ��ϼ���!</p>
            <div>
            <button type="button" class="btn btn-primary" onclick="changeFrameSrc('user/user_my_page.asp')">����������</button>
            <button type="button" class="btn btn-danger" onclick="logout()">�α׾ƿ�</button>
            </div>
        </div>
    <% end if %>
    <container class="d-flex mt-4 m-auto h-100">
        <div>
            <p><a href="#" class="text-reset text-decoration-none fw-bold" onclick="changeFrameSrc('game/game_list.asp')">��ü����</a></p>
            <p><a href="#" class="text-reset text-decoration-none" onclick="changeFrameSrc('game/game_list.asp?part=game')">����</a></p>
            <p><a href="#" class="text-reset text-decoration-none" onclick="changeFrameSrc('game/game_list.asp?part=console')">���ӱ�</a></p>
            <p><a href="#" class="text-reset text-decoration-none" onclick="changeFrameSrc('game/game_list.asp?part=movie')">��ȭ</a></p>

            <p><a href="#" class="text-decoration-none text-success fw-bold" onclick="changeFrameSrc('game/game_cart.asp')">��ٱ���</a></p>

            <% if session("id") <> "admin" then %>
            <p><a href="#" class="text-decoration-none text-danger fw-bold" onclick="changeFrameSrc('admin/admin_login.asp')">������ �α���</a></p>
            <% else %>
            <p><a href="#" class="text-decoration-none text-danger fw-bold" onclick="changeFrameSrc('admin/admin_main.asp')">������ �޴�</a></p>
            <% end if %>
        </div>
        <iframe id="my_frame" src="game/game_list.asp" class="ms-5" style="width: 90%;">
            
        </iframe>
    </container>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>