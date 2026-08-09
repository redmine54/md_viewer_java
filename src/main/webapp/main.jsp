<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<style>
    #tabs { display: flex; border-bottom: 1px solid #ccc; }
    .tab {
        padding: 8px 12px;
        border: 1px solid #ccc;
        border-bottom: none;
        margin-right: 4px;
        cursor: pointer;
        background: #eee;
        position: relative;
    }
    .tab.active { background: #fff; font-weight: bold; }
    .close-btn {
        position: absolute;
        right: 4px;
        top: 2px;
        cursor: pointer;
        color: red;
        font-weight: bold;
    }
    iframe {
        width: 100%;
        height: 90vh;
        border: none;
    }
</style>

<script>
function activateTab(tabId, iframeId) {
    document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
    document.getElementById(tabId).classList.add('active');

    document.querySelectorAll('iframe').forEach(f => f.style.display = 'none');
    document.getElementById(iframeId).style.display = 'block';
}

function closeTab(tabId, iframeId) {
    const tab = document.getElementById(tabId);
    const iframe = document.getElementById(iframeId);

    tab.remove();
    iframe.remove();

    // 残っているタブがあれば自動で先頭をアクティブにする
    const remainingTabs = document.querySelectorAll('.tab');
    if (remainingTabs.length > 0) {
        const firstTab = remainingTabs[0];
        const firstIframeId = firstTab.getAttribute("data-iframe");
        activateTab(firstTab.id, firstIframeId);
    }
}
</script>
</head>

<body>

<div id="tabs">
<%
    List<String> files = (List<String>) request.getAttribute("files");
    if (files != null) {
        int index = 0;
        for (String f : files) {
            String tabId = "tab" + index;
            String iframeId = "frame" + index;
            String name = new java.io.File(f).getName();
%>
    <div id="<%=tabId%>" class="tab" data-iframe="<%=iframeId%>"
         onclick="activateTab('<%=tabId%>', '<%=iframeId%>')">
        <%=name%>
        <span class="close-btn" onclick="event.stopPropagation(); closeTab('<%=tabId%>', '<%=iframeId%>')">×</span>
    </div>
<%
            index++;
        }
    }
%>
</div>

<div id="frames">
<%
    if (files != null) {
        int index = 0;
        for (String f : files) {
            String iframeId = "frame" + index;
%>
    <iframe id="<%=iframeId%>" src="render?file=<%=f%>" style="<%= index==0 ? "" : "display:none;" %>"></iframe>
<%
            index++;
        }
    }
%>
</div>

</body>
</html>
