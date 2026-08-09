package viewer;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import com.vladsch.flexmark.html.HtmlRenderer;
import com.vladsch.flexmark.parser.Parser;

public class MdRenderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // UTF-8 統一（重要）
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        // ファイルパス取得
        String file = req.getParameter("file");

        // Markdown を UTF-8 で読み込む（最重要）
        String md = Files.readString(Paths.get(file), StandardCharsets.UTF_8);

        // Markdown → HTML 変換
        Parser parser = Parser.builder().build();
        HtmlRenderer renderer = HtmlRenderer.builder().build();
        String htmlBody = renderer.render(parser.parse(md));

        // iframe 内で文字化けしないよう HTML ラッパーを付ける
        String html = """
            <!DOCTYPE html>
            <html lang="ja">
            <head>
                <meta charset="UTF-8">
            </head>
            <body>
            """ + htmlBody + """
            </body>
            </html>
            """;

        resp.getWriter().write(html);
    }
}
