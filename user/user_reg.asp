<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<%
if session("id") <> "" then
Response.Redirect("../game/game_list.asp")
end if

Dim c_name, c_pwd, c_postcode, c_address, c_detailAddress, c_extraAddress, c_tel

c_name = Request.Form("c_name")
c_pwd = Request.Form("c_pwd")
c_postcode = Request.Form("c_postcode")
c_address = Request.Form("c_address")
c_detailAddress = Request.Form("c_detailAddress")
c_extraAddress = Request.Form("c_extraAddress")
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
    <title>ȸ������</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function check_id() {
                document.getElementById("id_submit").disabled = true
            }
            $(document).ready(function() {
                // Handle form submission using AJAX
                $('button[name="check_dup"]').click(function(e) {
                    e.preventDefault(); // Prevent page refresh
                    const c_name = $('#c_name').val();
                    $.ajax({
                        type: 'POST',
                        url: './check_dup.asp',
                        data: {c_name: c_name},
                        success: function(data) {
                            // Render response data in the page
                            $('#result').html(data);
                            // Enable or disable the "ȸ������" button based on the response
                            if (data.includes('��� ������ ���̵��Դϴ�.')) {
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
        function c_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ�.

                    // �� �ּ��� ���� ��Ģ�� ���� �ּҸ� �����Ѵ�.
                    // �������� ������ ���� ���� ��쿣 ����('')���� �����Ƿ�, �̸� �����Ͽ� �б� �Ѵ�.
                    var addr = ''; // �ּ� ����
                    var extraAddr = ''; // �����׸� ����

                    //����ڰ� ������ �ּ� Ÿ�Կ� ���� �ش� �ּ� ���� �����´�.
                    if (data.userSelectedType === 'R') { // ����ڰ� ���θ� �ּҸ� �������� ���
                        addr = data.roadAddress;
                    } else { // ����ڰ� ���� �ּҸ� �������� ���(J)
                        addr = data.jibunAddress;
                    }

                    // ����ڰ� ������ �ּҰ� ���θ� Ÿ���϶� �����׸��� �����Ѵ�.
                    if(data.userSelectedType === 'R'){
                        // ���������� ���� ��� �߰��Ѵ�. (�������� ����)
                        // �������� ��� ������ ���ڰ� "��/��/��"�� ������.
                        if(data.bname !== '' && /[��|��|��]$/g.test(data.bname)){
                            extraAddr += data.bname;
                        }
                        // �ǹ����� �ְ�, ���������� ��� �߰��Ѵ�.
                        if(data.buildingName !== '' && data.apartment === 'Y'){
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        // ǥ���� �����׸��� ���� ���, ��ȣ���� �߰��� ���� ���ڿ��� �����.
                        if(extraAddr !== ''){
                            extraAddr = ' (' + extraAddr + ')';
                        }
                        // ���յ� �����׸��� �ش� �ʵ忡 �ִ´�.
                        document.getElementById("c_extraAddress").value = extraAddr;
                    
                    } else {
                        document.getElementById("c_extraAddress").value = '';
                    }

                    // �����ȣ�� �ּ� ������ �ش� �ʵ忡 �ִ´�.
                    document.getElementById('c_postcode').value = data.zonecode;
                    document.getElementById("c_address").value = addr;
                    // Ŀ���� ���ּ� �ʵ�� �̵��Ѵ�.
                    document.getElementById("c_detailAddress").focus();
                }
            }).open();
        }
    </script>
    <div style="width: 80%; align-items: center;">
        <h2>ȸ������</h2>        
        <form name="reg_form" action="./user_reg_ok.asp">
            <label for="c_name" class="mb-3 mt-4">���̵�</label>
            <div class="d-flex mb-0">
                <input type="text" value="<%=c_name%>" oninput="check_id()" class="form-control mb-3 w-75 h-100" name="c_name" id="c_name" minlength="2" maxlength="10" required>
                <button type="button" class="btn btn-outline-dark ms-2 mt-1 pt-1 pb-1 h-100" name="check_dup">�ߺ�üũ</button>
            </div>
            <div id="result" class="mb-3"></div>
            <label for="c_pwd" class="mb-3">��й�ȣ</label>
            <input type="password" value="<%=c_pwd%>" class="form-control mb-3" name="c_pwd" id="c_pwd" minlength="6" maxlength="15" required>
            <label for="c_addr" class="mb-3">�ּ�</label>
            <div class="input-group w-50">
                <input type="text" width="20px !important" class="form-control mb-3" name="c_postcode" id="c_postcode" placeholder="�����ȣ" readonly required>
                <input type="button" class="form-control mb-3" onclick="c_execDaumPostcode()" value="�����ȣ ã��" readonly required><br>
            </div>
            <input type="text" class="form-control mb-0" value="<%=c_address%>" name="c_address" id="c_address" placeholder="�ּ�" readonly required><br>
            <div class="d-flex">
                <input type="text" class="form-control mb-3 w-50 me-2" value="<%=c_detailAddress%>" name="c_detailAddress" id="c_detailAddress" placeholder="���ּ�">
                <input type="text" class="form-control mb-3" value="<%=c_extraAddress%>" name="c_extraAddress" id="c_extraAddress" placeholder="�����׸�" readonly required>
            </div>
            <label for="c_tel" class="mb-3">��ȭ��ȣ</label>
            <input type="text" value="<%=c_tel%>" class="form-control mb-3" name="c_tel" id="c_tel" required>
            <input type="submit" id="id_submit" class="btn btn-outline-success" value="ȸ������" disabled>
        </form>
    </div>
</body>
</html>