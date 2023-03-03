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
    <title>새 상품 등록</title>
</head>
<body>
    <div style="width: 80%; align-items: center;">
        <h2>새 상품 등록하기</h2>
        <form name="reg_form" method="post" action="./goods_new_ok.asp">
            <label for="g_code">상품코드</label>
            <input type="text" class="form-control mb-3" name="g_code" id="g_code" required>
            <label for="g_part">제품구분</label>
            <input type="text" class="form-control mb-3" name="g_part" id="g_part" required>
            <label for="g_name">제품명</label>
            <input type="text" class="form-control mb-3" name="g_name" id="g_name" required>
            <label for="g_maker">제조회사</label>
            <input type="text" class="form-control mb-3" name="g_maker" id="g_maker" required>
            <label for="g_image">이미지</label>
            <input type="text" class="form-control mb-3" name="g_image" id="g_image" required>
            <label for="g_ori_price">정가</label>
            <input type="text" class="form-control mb-3" name="g_ori_price" id="g_ori_price" required>
            <label for="g_sell_price">판매가</label>
            <input type="text" class="form-control mb-3" name="g_sell_price" id="g_sell_price" required>
            <label for="g_content">제품설명</label>
            <textarea type="text" class="form-control mb-3" name="g_content" id="g_content"></textarea>
            <input type="submit" class="btn btn-outline-success" value="상품 등록">
        </form>
    </div>
</body>
</html>