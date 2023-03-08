<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<% 
Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=ShopDB; UID=sa; PWD=1234;")

c_code = Session("id")

sql = "SELECT * FROM Game_Customer WHERE c_code = '" & c_code & "'"

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, db, 1

c_name = rs("c_name")
c_postcode = rs("c_postcode")
c_address = rs("c_address")
c_detailAddress = rs("c_detailAddress")
c_extraAddress = rs("c_extraAddress")
c_tel = rs("c_tel")
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
        <h2>정보수정</h2>        
        <form name="reg_form" action="./user_my_page_ok.asp">
            <label for="c_name" class="mb-3 mt-4">아이디</label>
            <input type="text" value="<%=c_name%>" oninput="check_id()" class="form-control mb-3 w-75 h-100" name="c_name" id="c_name" minlength="2" maxlength="10" required>
            <div id="result" class="mb-3"></div>
            <label for="c_pwd" class="mb-3">비밀번호</label>
            <input type="password" value="<%=c_pwd%>" class="form-control mb-3" name="c_pwd" id="c_pwd" minlength="6" maxlength="15" required>
            <label for="c_addr" class="mb-3">주소</label>
            <div class="input-group w-50">
                <input type="text" width="20px !important" class="form-control mb-3" value="<%=c_postcode%>" name="c_postcode" id="c_postcode" placeholder="우편번호" readonly required>
                <input type="button" class="form-control mb-3" onclick="c_execDaumPostcode()" value="우편번호 찾기" readonly required><br>
            </div>
            <input type="text" class="form-control mb-0" value="<%=c_address%>" name="c_address" id="c_address" placeholder="주소" readonly required><br>
            <div class="d-flex">
                <input type="text" class="form-control mb-3 w-50 me-2" value="<%=c_detailAddress%>" name="c_detailAddress" id="c_detailAddress" placeholder="상세주소">
                <input type="text" class="form-control mb-3" value="<%=c_extraAddress%>" name="c_extraAddress" id="c_extraAddress" placeholder="참고항목" readonly required>
            </div>
            <label for="c_tel" class="mb-3">전화번호</label>
            <input type="text" value="<%=c_tel%>" class="form-control mb-3" name="c_tel" id="c_tel" required>
            <input type="submit" id="id_submit" class="btn btn-outline-success" value="정보수정">
        </form>
    </div>
</body>
</html>