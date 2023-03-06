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
    <link rel="stylesheet" href="./default.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <title>ȸ������</title>
</head>
<body>
    <div style="width: 80%; align-items: center;">
        <h2>������ �α���</h2>
        <form name="reg_form" method="post" action="./admin_login_ok.asp">
            <label for="c_name">���̵�</label>
            <div class="d-flex flex-nowrap">
                <input type="text" class="form-control mb-3" name="c_name" id="c_name" minlength="2" maxlength="10" required>
            </div>
            <label for="c_pwd">��й�ȣ</label>
            <input type="password" class="form-control mb-3" name="c_pwd" id="c_pwd" maxlength="15" required>
            <input type="submit" class="btn btn-outline-success" value="�α���">
            <hr>
            <p>�����ڰ� �ƴϽŰ���? �Ϲ� �α���</p>
            <button type="button" onclick="location.href='../user/user_login.asp'" class="btn btn-outline-secondary">�Ϲ� �α���</button>
        </form>
    </div>
</body>
</html>