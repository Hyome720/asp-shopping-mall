<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<%
Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=ShopDB; UID=sa; PWD=1234;")

Set rs = Server.CreateObject("ADODB.Recordset")
sql = "SELECT c_name, c_postcode, c_address, c_detailAddress, c_extraAddress, c_tel FROM Game_Customer"
sql = sql & " WHERE c_code = '" & Session("id") & "'"

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
    <!-- CSS only -->
    <link rel="stylesheet" href="./default.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <title>ȸ������</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div style="width: 80%; align-items: center;">
        <h2>�ֹ��ϱ�</h2>        
        <form name="reg_form" action="game_order_ok.asp">
            <label for="c_name">�̸�</label>
            <input type="text" value="<%=c_name%>" class="form-control mb-3" name="c_name" minlength="2" maxlength="10" required>
            <label for="c_addr" class="mb-3">�ּ�</label>
            <div class="input-group w-50">
                <input type="text" width="20px !important" class="form-control mb-3" value="<%=c_postcode%>" name="c_postcode" id="c_postcode" placeholder="�����ȣ" readonly required>
                <input type="button" class="form-control mb-3" onclick="c_execDaumPostcode()" value="�����ȣ ã��" readonly required><br>
            </div>
            <input type="text" class="form-control mb-0" value="<%=c_address%>" name="c_address" id="c_address" placeholder="�ּ�" readonly required><br>
            <div class="d-flex">
                <input type="text" class="form-control mb-3 w-50 me-2" value="<%=c_detailAddress%>" name="c_detailAddress" id="c_detailAddress" placeholder="���ּ�">
                <input type="text" class="form-control mb-3" value="<%=c_extraAddress%>" name="c_extraAddress" id="c_extraAddress" placeholder="�����׸�" readonly required>
            </div>
            <label for="c_tel">��ȭ��ȣ</label>
            <input type="text" value="<%=c_tel%>" class="form-control mb-3" name="c_tel" id="c_tel" required>
            <label for="bank_acc">�Աݰ���</label>
            <select class="form-select" name="bank_acc" aria-label="Default select example" required>
                <option selected value="">�Ա� �Ͻ� ���¸� �����ϼ���.</option>
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
    <script>
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
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>