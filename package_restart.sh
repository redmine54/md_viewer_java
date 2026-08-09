cd ~/git_lesson/md_viewer_java
mvn clean package
cp target/md_viewer_java.war /opt/homebrew/Cellar/tomcat/11.0.24/libexec/webapps/

# Tomcat restart
brew services restart tomcat

# 待機ループ（8090 が開くまで待つ）
echo "Tomcat が起動するまで待機します..."
sleep 1
while ! lsof -i :8090 >/dev/null 2>&1; do
    sleep 1
done

echo "Tomcat 起動完了！"

# 次の処理
open -a "Microsoft Edge" http://localhost:8090/md_viewer_java/

