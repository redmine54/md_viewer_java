<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>md viewer</title>

<style>
    /* ★ ページ全体の縦レイアウト（タイトル → 本体） */
    .page {
        display: flex;
        flex-direction: column;
        height: 100vh;
        width: 100vw;
        overflow: hidden;
    }

    /* ★ タイトル領域 */
    .page-title {
        padding: 12px 20px;
        font-size: 22px;
        font-weight: bold;
        background: #e8e8e8;
        border-bottom: 1px solid #ccc;
        box-sizing: border-box;
    }

    /* ★ 左メニュー＋右メインの横並びレイアウト */
    .layout {
        display: flex;
        flex: 1;
        overflow: hidden;
    }

    /* 左メニュー */
    .menu-container {
        width: 260px;
        padding: 10px;
        padding-right: 20px; /* スクロールバー対策 */
        background: #f0f0f0;
        border-right: 1px solid #ccc;
        overflow-y: auto;
        box-sizing: border-box;
    }

    /* 右メイン（残り全部の幅） */
    .main-container {
        flex: 1;
        overflow: auto;
        background: #ffffff;
        padding: 10px;
        box-sizing: border-box;
    }
</style>
</head>

<body>

<div class="page">

    <!-- ★ 最上位タイトル -->
    <div class="page-title">
        Markdown形式ファイルのドキュメント形式表示
    </div>

    <div class="layout">

        <!-- 左メニュー -->
        <div class="menu-container">
            <%@ include file="menu.jsp" %>
        </div>

        <!-- 右メイン -->
        <div class="main-container">
            <%
                Object filesObj = request.getAttribute("files");
                if (filesObj != null) {
            %>
                <%@ include file="main.jsp" %>
            <%
                } else {
            %>
                <div style="padding:20px; font-size:18px;">
                    ここは md が表示されます
                </div>
            <%
                }
            %>
        </div>

    </div>
</div>

</body>
</html>
