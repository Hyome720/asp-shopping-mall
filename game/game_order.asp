<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<%
Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=ShopDB; UID=sa; PWD=1234;")

Set rs = Server.CreateObject("ADODB.Recordset")
sql = "SELECT c_name, c_addr, c_tel FROM Game_Customer"
sql = sql & " WHERE c_code = '" & Session("id") & "'"

rs.Open sql, db, 1

c_name = rs("c_name")
c_addr = rs("c_addr")
c_tel = rs("c_tel")
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div style="width: 80%; align-items: center;">
        <h2>ȸ������</h2>        
        <form name="reg_form" action="game_order_ok.asp">
            <label for="c_name">�̸�</label>
            <input type="text" value="<%=c_name%>" class="form-control mb-3" name="c_name" minlength="2" maxlength="10" required>
            <label for="c_addr">���ó</label>
            <input type="text" value="<%=c_addr%>" class="form-control mb-3" name="c_addr" id="c_addr" required>
            <label for="c_tel">��ȭ��ȣ</label>
            <input type="text" value="<%=c_tel%>" class="form-control mb-3" name="c_tel" id="c_tel" required>
            <label for="bank_acc">�Աݰ���</label>
            <select class="form-select" aria-label="Default select example">
                <option selected>�Ա� �Ͻ� ���¸� �����ϼ���.</option>
                <option value="��������">�������� : 020303-23-94951</option>
                <option value="�츮����">�츮���� : 68543-2345-345435</option>
            </select>
            <p>
            ������ : <%=formatcurrency(Request("total_price"))%>
            <input type="hidden" name="total_price" value="<%=Request("total_price")%>"
            </p>
            <hr>
            <input type="submit" id="id_submit" class="btn btn-outline-success" value="�ֹ��ϱ�">
        </form>
        <div id="result"></div>
    </div>
</body>
</html>