package viewer;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.MultipartConfig;
import java.io.*;
import java.nio.file.*;
import java.nio.charset.StandardCharsets;
import java.util.*;

@MultipartConfig
public class FileSelectServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        Collection<Part> parts = req.getParts();
        List<String> files = new ArrayList<>();

        for (Part part : parts) {
            String filename = part.getSubmittedFileName();

            if (filename != null && filename.endsWith(".md")) {
                Path temp = Files.createTempFile("md_", ".md");

                try (InputStream in = part.getInputStream();
                     OutputStream out = Files.newOutputStream(temp)) {
                    in.transferTo(out);
                }

                files.add(temp.toAbsolutePath().toString());
            }
        }

        // main.jsp ではなく index.jsp に forward することが重要
        req.setAttribute("files", files);
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }
}
