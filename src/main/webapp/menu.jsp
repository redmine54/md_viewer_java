<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>メニュー</title>

<style>
    /* 左メニュー全体の背景色と幅 */
    .menu-container {
        width: 260px;
        padding: 10px;
        padding-right: 20px; /* ★スクロールバー対策：右側に余白を追加 */
        background: #f0f0f0;
        border-right: 1px solid #ccc;
        height: 100vh;
        overflow-y: auto; /* ★スクロールバーが出ても ▼ が隠れない */
        box-sizing: border-box;
    }

    .select-row {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
    }

    /* テキストフィールドは 200px */
    .text-display {
        width: 200px;
        padding: 6px;
        border: 1px solid #ccc;
        background: #fff;
        font-size: 14px;
    }

    /* ▼アイコンボタン（選択ボタンの代わり） */
    .icon-btn {
        position: relative;
        width: 30px;
        height: 30px;
        margin-left: 4px;
        margin-right: 4px; /* ★スクロールバーと重ならないように余白追加 */
        cursor: pointer;
        border: 1px solid #ccc;
        background: #e6e6e6;
        font-size: 18px;
        text-align: center;
        line-height: 28px;
        border-radius: 4px;
        transition: background 0.2s;
        user-select: none;
    }

    .icon-btn:hover {
        background: #d0d0d0;
    }

    /* ▼ボタンの上に透明な input を重ねる */
    .file-overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 30px;
        height: 30px;
        opacity: 0; /* 完全透明 */
        cursor: pointer;
    }

    .hidden-file {
        display: none;
    }
</style>

<script>
let mdFiles = [];

function handleFolder(input) {
    mdFiles = [];
    const mdNames = [];

    for (let f of input.files) {
        if (f.name.endsWith(".md")) {
            mdFiles.push(f);
            mdNames.push(f.name);
        }
    }

    document.getElementById("folderText").value =
        mdNames.length > 0 ? mdNames.join(", ") : "フォルダ選択";

    rebuildHiddenInput();
}

function handleFiles(input) {
    mdFiles = [];
    const mdNames = [];

    for (let f of input.files) {
        if (f.name.endsWith(".md")) {
            mdFiles.push(f);
            mdNames.push(f.name);
        }
    }

    document.getElementById("fileText").value =
        mdNames.length > 0 ? mdNames.join(", ") : "ファイル選択";

    rebuildHiddenInput();
}

function rebuildHiddenInput() {
    const hidden = document.getElementById("hiddenInput");
    const dt = new DataTransfer();

    for (let f of mdFiles) {
        dt.items.add(f);
    }

    hidden.files = dt.files;
}
</script>
</head>

<body>

<div class="menu-container">

<form action="select" method="post" enctype="multipart/form-data">

    <!-- ▼ フォルダ選択 -->
    <div class="select-row">
        <input type="text" id="folderText" class="text-display" readonly value="フォルダ選択">

        <div class="icon-btn">▼
            <input type="file" class="file-overlay"
                   webkitdirectory directory onchange="handleFolder(this)">
        </div>
    </div>

    <!-- ▼ ファイル選択 -->
    <div class="select-row">
        <input type="text" id="fileText" class="text-display" readonly value="ファイル選択">

        <div class="icon-btn">▼
            <input type="file" class="file-overlay"
                   accept=".md" multiple onchange="handleFiles(this)">
        </div>
    </div>

    <!-- mdFiles だけ送信する hidden input -->
    <input type="file" id="hiddenInput" name="mdfiles" class="hidden-file" multiple>

    <button type="submit">表示</button>
</form>

</div>

</body>
</html>
