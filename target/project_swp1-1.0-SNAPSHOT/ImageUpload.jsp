<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Image Upload</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>
        .image-preview {
            display: inline-block;
            margin: 10px;
            position: relative;
        }
        .image-preview img {
            max-width: 100px;
            max-height: 100px;
        }
        .image-preview .remove-image {
            position: absolute;
            top: 0;
            right: 0;
            cursor: pointer;
            color: red;
        }
    </style>
</head>
<body>
    <form id="uploadForm" action="UploadServlet" method="post" enctype="multipart/form-data">
        <table>
            <tr>
                <th>Product ID</th>
                <td><input type="text" name="product_id" required></td>
            </tr>
            <tr>
                <th>Images</th>
                <td>
                    <input type="file" name="images[]" id="imageInput" multiple required>
                    <div id="selectedFiles"></div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <button type="submit">Upload</button>
                </td>
            </tr>
        </table>
    </form>

    <script>
    $(document).ready(function() {
        var MAX_FILES_ALLOWED = 5;
        var selectedFilesContainer = $('#selectedFiles');

        $('#imageInput').change(function(e) {
            var files = e.target.files;

            if (files.length + selectedFilesContainer.find('.image-preview').length > MAX_FILES_ALLOWED) {
                alert('You can only upload up to ' + MAX_FILES_ALLOWED + ' images.');
                return;
            }

            for (var i = 0; i < files.length; i++) {
                var file = files[i];
                var reader = new FileReader();
                
                reader.onload = function(e) {
                    var img = $('<img>').attr('src', e.target.result);
                    var removeBtn = $('<span class="remove-image">X</span>');

                    removeBtn.click(function() {
                        $(this).parent().remove();
                    });

                    var imgPreview = $('<div class="image-preview"></div>')
                        .append(img)
                        .append(removeBtn);
                    selectedFilesContainer.append(imgPreview);
                };

                reader.readAsDataURL(file);
            }
        });

        $('#addImage').click(function() {
            $('#imageInput').click();
        });

        $('#uploadForm').submit(function(e) {
            if (selectedFilesContainer.find('.image-preview').length > MAX_FILES_ALLOWED) {
                alert('You cannot upload more than ' + MAX_FILES_ALLOWED + ' images.');
                e.preventDefault(); // Stop form submission
            }
        });
    });
    </script>

</body>
</html>
