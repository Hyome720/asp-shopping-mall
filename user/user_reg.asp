<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<%
Dim c_name, c_pwd, c_addr, c_tel

If Request.Form("c_name") <> "" And Request.Form("c_pwd") <> "" And Request.Form("c_tel") <> "" Then
    c_name = Request.Form("c_name")
    c_pwd = Request.Form("c_pwd")
    c_addr = Request.Form("c_addr")
    c_tel = Request.Form("c_tel")
    
    ' Do some processing or validation with the form data here
    
    ' Return some response data to the client
    Response.Write("<p>ȸ�������� �Ϸ�Ǿ����ϴ�.</p>")
    Response.Write("<p>���̵�: " & c_name & "</p>")
    Response.Write("<p>��й�ȣ: " & c_pwd & "</p>")
    Response.Write("<p>�ּ�: " & c_addr & "</p>")
    Response.Write("<p>��ȭ��ȣ: " & c_tel & "</p>")
Else
    Response.Write("<p>��� �ʼ� �׸��� �Է��ϼ���.</p>")
End If
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
    <script>
        $(document).ready(function() {
            // Handle form submission using AJAX
            $('form[name="reg_form"]').submit(function(e) {
                e.preventDefault(); // Prevent page refresh
                $.ajax({
                    type: 'POST',
                    url: './user_reg_ok.asp',
                    data: $('form[name="reg_form"]').serialize(),
                    success: function(data) {
                        // Render form data in the page
                        $('#result').html(data);
                    },
                    error: function() {
                        alert('Error submitting form');
                    }
                });
            });
        });

        function c_name_check(data) {
            data.action = "./user_reg.asp"
            data.submit()
            return true
        }
    </script>
    <div style="width: 80%; align-items: center;">
        <h2>ȸ������</h2>
        <form name="reg_form" method="post">
            <label for="c_name">���̵�</label>
            <div class="d-flex flex-nowrap">
                <input type="text" value="<%=c_name%>" class="form-control mb-3" name="c_name" id="c_name" minlength="2" maxlength="10"required>
                <button type="button" class="btn btn-outline-dark ms-2" onclick="return c_name_check(this.form)">�ߺ�üũ</button>
            </div>
            <label for="c_pwd">��й�ȣ</label>
            <input type="password" value="<%=c_pwd%>" class="form-control mb-3" name="c_pwd" id="c_pwd" minlength="6" maxlength="15" required>
            <label for="c_addr">�ּ�</label>
            <input type="text" value="<%=c_addr%>" class="form-control mb-3" name="c_addr" id="c_addr">
            <label for="c_tel">��ȭ��ȣ</label>
            <input type="text" value="<%=c_tel%>" class="form-control mb-3" name="c_tel" id="c_tel" required>
            <input type="submit" class="btn btn-outline-success" value="ȸ������">
        </form>
        <div id="result"></div>
    </div>
</body>
</html>