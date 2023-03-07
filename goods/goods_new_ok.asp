<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<%

Set uploadform = Server.CreateObject("DEXT.FileUpload")
uploadform.DefaultPath = "C:\inetpub\wwwroot\asp_mall\img"
g_part = uploadform("g_part")
g_name = uploadform("g_name")
g_maker = uploadform("g_maker")
g_image = uploadform.FileName
g_ori_price = uploadform("g_ori_price")
g_sell_price = uploadform("g_sell_price")
g_content = uploadform("g_content")

uploadform.Save

Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=ShopDB;UID=sa;PWD=1234;")

sql = "INSERT INTO Game_Goods VALUES ("
sql = sql & "'" & g_code & "'"
sql = sql & ",'" & g_part & "'"
sql = sql & ",'" & g_name & "'"
sql = sql & ",'" & g_maker & "'"
sql = sql & "," & g_ori_price
sql = sql & "," & g_sell_price
sql = sql & ",'" & g_image & "'"
sql = sql & ",'" & g_content & "'"
sql = sql & ",'" & now() & "')"

db.Execute(sql)
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
    <script>
        alert("제품 등록에 성공했습니다!")
    </script>
    <div class="alert alert-success" role="alert">
        상품 등록에 성공했습니다!
    </div>
</body>
</html>