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
    <title>회원가입</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div style="width: 80%; align-items: center;">
        <h2>주문하기</h2>        
        <form name="reg_form" action="game_order_ok.asp">
            <label for="c_name">이름</label>
            <input type="text" value="<%=c_name%>" class="form-control mb-3" name="c_name" minlength="2" maxlength="10" required>
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
            <label for="c_tel">전화번호</label>
            <input type="text" value="<%=c_tel%>" class="form-control mb-3" name="c_tel" id="c_tel" required>
            <label for="bank_acc">입금계좌</label>
            <select class="form-select" name="bank_acc" aria-label="Default select example" required>
                <option selected value="">입금 하실 계좌를 선택하세요.</option>
                <option value="국민은행">국민은행 : 020303-23-94951</option>
                <option value="우리은행">우리은행 : 68543-2345-345435</option>
            </select>
            <p>
            결제액 : <%=formatcurrency(Request("total_price"))%>
            <input type="hidden" name="total_price" value="<%=Request("total_price")%>"
            </p>
            <hr>
            <input type="submit" id="id_submit" class="btn btn-outline-success" value="주문하기">
        </form>
        <div id="result"></div>
    </div>
    <script>
        function c_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var addr = ''; // 주소 변수
                    var extraAddr = ''; // 참고항목 변수

                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }

                    // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                    if(data.userSelectedType === 'R'){
                        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                            extraAddr += data.bname;
                        }
                        // 건물명이 있고, 공동주택일 경우 추가한다.
                        if(data.buildingName !== '' && data.apartment === 'Y'){
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                        if(extraAddr !== ''){
                            extraAddr = ' (' + extraAddr + ')';
                        }
                        // 조합된 참고항목을 해당 필드에 넣는다.
                        document.getElementById("c_extraAddress").value = extraAddr;
                    
                    } else {
                        document.getElementById("c_extraAddress").value = '';
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('c_postcode').value = data.zonecode;
                    document.getElementById("c_address").value = addr;
                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById("c_detailAddress").focus();
                } 
            }).open();
        }
    </script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>