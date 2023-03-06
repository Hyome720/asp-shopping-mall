<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<%
if session("id") <> "" then
Response.Redirect("../game/game_list.asp")
end if

Dim c_name, c_pwd, c_addr, c_tel

c_name = Request.Form("c_name")
c_pwd = Request.Form("c_pwd")
c_addr = Request.Form("c_addr")
c_tel = Request.Form("c_tel")
    
Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=ShopDB; UID=sa; PWD=1234;")

if c_name <> "" then
    sql = "SELECT * FROM Game_Customer WHERE c_name = '" & c_name & "'"

    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, db, 1
end if
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- CSS only -->
    <link rel="stylesheet" href="./default.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <title>회원가입</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <script>
        function check_id() {
            document.getElementById("id_submit").disabled = true
        }
        $(document).ready(function() {
            // Handle form submission using AJAX
            $('button[name="check_dup"]').click(function(e) {
                e.preventDefault(); // Prevent page refresh
                var c_name = $('#c_name').val();
                $.ajax({
                    type: 'POST',
                    url: './check_dup.asp',
                    data: {c_name: c_name},
                    success: function(data) {
                        // Render response data in the page
                        $('#result').html(data);
                        // Enable or disable the "회원가입" button based on the response
                        if (data.includes('사용 가능한 아이디입니다.')) {
                            $('input[type="submit"]').prop('disabled', false);
                        } else {
                            $('input[type="submit"]').prop('disabled', true);
                        }
                    },
                    error: function() {
                        alert('Error checking duplicate');
                    }
                });
            });
        });
    </script>
    <div style="width: 80%; align-items: center;">
        <h2>회원가입</h2>        
        <form name="reg_form" action="./user_reg_ok.asp">
            <label for="c_name">아이디</label>
            <div class="d-flex flex-nowrap">
                <input type="text" value="<%=c_name%>" oninput="check_id()" class="form-control mb-3" name="c_name" id="c_name" minlength="2" maxlength="10" required>
                <button type="button" class="btn btn-outline-dark ms-2" name="check_dup">중복체크</button>
            </div>
            <label for="c_pwd">비밀번호</label>
            <input type="password" value="<%=c_pwd%>" class="form-control mb-3" name="c_pwd" id="c_pwd" minlength="6" maxlength="15" required>
            <label for="c_addr">주소</label>
            <input type="text" value="<%=c_addr%>" class="form-control mb-3" name="c_addr" id="c_addr">
            <label for="c_tel">전화번호</label>
            <input type="text" value="<%=c_tel%>" class="form-control mb-3" name="c_tel" id="c_tel" required>
            <input type="submit" id="id_submit" class="btn btn-outline-success" value="회원가입" disabled>
        </form>
        <div id="result"></div>
    </div>
</body>
</html>