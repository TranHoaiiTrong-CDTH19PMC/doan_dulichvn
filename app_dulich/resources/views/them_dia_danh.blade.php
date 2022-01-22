<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="./css/style_request2.css">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    
    <title>Thêm từ mới</title>
</head>
<body class="background-color1">
    <div class="">
        <form action="{{route('xl_them_dia_danh')}}" method ="POST" enctype="multipart/form-data"  class="modal-content animate">
           @csrf
        <div class="container">
                    <input type="hidden" name="id" value="">
                    <h1>Thêm địa danh mới</h1>
                    <div class="mb-3">
                        <label for="class_name"><b>Tên địa danh</b></label>
                        <div class="input-group">
                            <input value= "" type="text" class="form-control" id="class_name" placeholder="Tên địa danh" name="name" required>
                        </div>   
                    </div>
                  
                    <div class="mb-3">
                    <label for="class_code"><b>Địa điểm</b></label>
                        <div class="input-group">
                        <input value= "" type="text" class="form-control" id="class_code" placeholder="Địa điểm" name="tagLine" required>
                        </div>
                    </div>
                    <div class="mb-3">
                    <label for="class_code"><b>Hình ảnh</b></label>
                        <div class="input-group">
                        <input value= "" type="text" class="form-control" id="class_code" placeholder="Hình ảnh" name="image" required>
                        </div>
                    </div>
                    <div class="mb-3">
                    <label for="class_code"><b>Hình ảnh thêm</b></label>
                        <div class="input-group">
                        <input value= "" type="text" class="form-control" id="class_code" placeholder="Hình ảnh thêm" name="images" required>
                        </div>
                    </div>
                    <div class="mb-3">
                    <label for="class_code"><b>Mô tả</b></label>
                        <div class="input-group">
                        <input value= "" type="text" class="form-control" id="class_code" placeholder="Mô tả" name="description" required>
                        </div>
                    </div>
                    
                    <button class="btn btn-success btn-lg btn-block" type="submit">Thêm địa danh</button>                 
             
            </div>
        </form>
    </div> 
</body>
</html>