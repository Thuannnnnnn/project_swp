<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<%@ page import="dao.CategoryDAO" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Category</title>
    <style>
        .body-style {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }
        .container-style {
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .title-style {
            color: #333;
        }
        .form-style {
            margin-top: 15px;
        }
        .input-hidden-style {
            display: none;
        }
        .label-style {
            display: block;
            margin: 10px 0;
        }
        .input-text-style {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
        .submit-btn-style {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            border: none;
            background-color: #5cb85c;
            color: white;
            cursor: pointer;
        }
        .submit-btn-style:hover {
            background-color: #4cae4c;
        }
        .back-link-style {
            display: inline-block;
            margin-top: 20px;
            color: #0066cc;
            text-decoration: none;
        }
        .back-link-style:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body class="body-style">
    <div class="container-style">
        <h2 class="title-style">Edit Category</h2>
        <%
            Category category = (Category) request.getAttribute("category");
            if (category != null) {
        %>
            <form class="form-style" action="crudCategory" method="post">
                <input class="input-hidden-style" type="hidden" name="action" value="edit" />
                <input class="input-hidden-style" type="hidden" name="categoryId" value="<%= category.getCategoryId() %>" />

                <label class="label-style" for="categoryName">Category Name:</label>
                <input class="input-text-style" type="text" id="categoryName" name="categoryName" value="<%= category.getCategoryName() %>" required>

                <input class="submit-btn-style" type="submit" value="Update Category">
            </form>
        <%
            } else {
        %>
            <p>Category not found.</p>
        <%
            }
        %>
        <a href="crudCategory" class="back-link-style">Back to Category List</a>
    </div>
</body>
</html>
