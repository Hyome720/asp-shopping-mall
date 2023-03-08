<%
response.codepage = 949
response.charset = "EUC-KR"
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
    <div style="width: 80%; align-items: center;">
        <h2>비밀번호 수정</h2>        
        <form name="reg_form" action="./user_pwd_change_ok.asp">
            <label for="c_pwd" class="mb-3 mt-4">기존 비밀번호</label>
            <input type="password" oninput="check_id()" class="form-control mb-3 w-75 h-100" name="c_pwd" id="c_pwd" minlength="2" maxlength="10" required>
            <label for="c_pwd_new" class="mb-3">새 비밀번호</label>
            <input type="password" class="form-control mb-3 w-75" name="c_pwd_new" id="c_pwd_new" minlength="6" maxlength="15" required>
            <input type="submit" id="id_submit" class="btn btn-outline-success" value="정보수정">
        </form>
    </div>
</body>
</html>