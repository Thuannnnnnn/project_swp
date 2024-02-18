<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Image Upload</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
    <form id="uploadForm" action="UploadServlet" method="post" enctype="multipart/form-data">
        <table>
            <tr>
                <th>Product_id</th> 
                <td> <input type="text" name="product_id" required> </td>
            </tr>
            <tr id="fileInputContainer">
                <!-- Vùng hiển thị các tệp đã chọn -->
            </tr>
            <tr>
                <td colspan="2">
                    <button type="button" id="addImage">Add Image</button>
                </td>
            </tr>
            <tr>
                <th></th> 
                <td> <input type="submit" value="Upload"> </td>
            </tr>
        </table>
    </form>

    <script>
    $(document).ready(function() {
        var fileInputContainer = $("#fileInputContainer");
        var addImageButton = $("#addImage");

        addImageButton.click(function() {
            var fileInput = $('<input type="file" name="images[]" style="display:none;" required>');
            fileInputContainer.append(fileInput);
            fileInput.click();

            fileInput.change(function() {
                var fileName = fileInput.val().split('\\').pop();
                fileInputContainer.append('<div>' + fileName + '</div>');
            });
        });
    });
</script>

</body>
</html>
