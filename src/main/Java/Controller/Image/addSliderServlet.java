package Controller.Image;

import dao.imageDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;

import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;

import model.image;
import org.apache.commons.io.IOUtils;

@MultipartConfig
public class addSliderServlet extends HttpServlet {
private static final Logger LOGGER = Logger.getLogger(addSliderServlet.class.getName());
   @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productIdStr = request.getParameter("product_id");
        if (productIdStr == null || productIdStr.trim().isEmpty()) {

            return; // Do not process if product_id is missing
        }

        int productId;
        try {
            productId = Integer.parseInt(productIdStr);
        } catch (NumberFormatException e) {

            return;
        }
       
        imageDAO dao = new imageDAO();
        int imageCount = 0;

        for (Part imagePart : request.getParts()) {
           
            
            if (!"images[]".equals(imagePart.getName()) || imagePart.getSize() <= 0) {
             
                continue; // Skip if not an image part or if size is 0
            }
            if (imageCount >= 5) { // Check if the limit of 5 images is reached
              
                request.setAttribute("error", "Cannot add more than 5 images.");
                request.getRequestDispatcher("/path-to-your-error-page").forward(request, response);
                return;
            }
            try (InputStream inputStream = imagePart.getInputStream()) {
                String contentType = imagePart.getContentType();
                if (!isValidImageType(contentType) || imagePart.getSize() > 10485760) { // 10 MB limit
                  
                    continue; // Skip if not a valid image type or too large
                }

                String imageBase64 = convertImageToBase64(inputStream);
                image img = new image();
                img.setProduct_id(productId);
                img.setImage_url(imageBase64);
                dao.addImage(img);
                imageCount++; // Increment valid image count
               
            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "Error processing image: {0}", e.getMessage());
                // Error handling; can log error if needed
            }
        }
        // Redirect the user if needed
        response.sendRedirect("/admin-setting");
    }

    private String convertImageToBase64(InputStream inputStream) throws IOException {
        byte[] imageBytes = IOUtils.toByteArray(inputStream);
        return Base64.getEncoder().encodeToString(imageBytes);
    }

    private boolean isValidImageType(String contentType) {
        return contentType.equals("image/jpeg") || contentType.equals("image/png");
    }
}