<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<%
c_pwd = Request("c_pwd")
c_pwd_new = Request("c_pwd_new")

Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=ShopDB; UID=sa; PWD=1234;")

sql = "SELECT c_pwd FROM Game_Customer WHERE c_code = '" & Session("id") & "'"

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, db, 1

if c_pwd <> rs("c_pwd") then
Response.Write("<script>alert('기존 비밀번호가 일치하지 않아요');history.back();</script>")

else
sql = "UPDATE Game_Customer SET c_pwd = '" & c_pwd_new & "'"
sql = sql & " WHERE c_code = '" & Session("id") & "'"

db.Execute(sql)

Response.Write("<script>alert('비밀번호가 변경되었습니다.');</script>")
Response.Write("<script>parent.location.reload();</script>")

end if

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
        <form name="reg_form" action="./user_my_page_ok.asp">
            <label for="c_name" class="mb-3 mt-4">기존 비밀번호</label>
            <input type="text" value="<%=c_name%>" oninput="check_id()" class="form-control mb-3 w-75 h-100" name="c_name" id="c_name" minlength="2" maxlength="10" required>
            <label for="c_pwd" class="mb-3">새 비밀번호</label>
            <input type="password" value="<%=c_pwd%>" class="form-control mb-3 w-75" name="c_pwd" id="c_pwd" minlength="6" maxlength="15" required>
            <input type="submit" id="id_submit" class="btn btn-outline-success" value="정보수정">
        </form>
    </div>
</body>
</html>