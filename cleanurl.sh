#!/bin/bash
# 물방울 — .html 없는 주소로 바꾸기
# 저장소 최상단(index.html 있는 곳)에서 실행하세요.
set -e

if [ ! -f index.html ]; then
  echo "index.html이 없습니다. 저장소 최상단에서 실행하세요."; exit 1
fi

echo "1) 폴더 만들고 파일 옮기는 중..."
mkdir -p editor privacy guide/start guide/blob guide/unity guide/making

cp editor.html        editor/index.html
cp privacy.html       privacy/index.html
cp guide-start.html   guide/start/index.html
cp guide-blob.html    guide/blob/index.html
cp guide-unity.html   guide/unity/index.html
cp guide-making.html  guide/making/index.html

echo "2) 링크 고치는 중..."
# 새 위치의 파일들 + 루트 index.html 전부
TARGETS="index.html editor/index.html privacy/index.html guide/start/index.html guide/blob/index.html guide/unity/index.html guide/making/index.html"

for f in $TARGETS; do
  sed -i \
    -e 's|href="style.css"|href="/style.css"|g' \
    -e 's|href="./"|href="/"|g' \
    -e 's|href="editor.html"|href="/editor/"|g' \
    -e 's|href="guide-start.html"|href="/guide/start/"|g' \
    -e 's|href="guide-blob.html"|href="/guide/blob/"|g' \
    -e 's|href="guide-unity.html"|href="/guide/unity/"|g' \
    -e 's|href="guide-making.html"|href="/guide/making/"|g' \
    -e 's|href="privacy.html"|href="/privacy/"|g' \
    -e 's|mulbangul.com/editor.html|mulbangul.com/editor/|g' \
    -e 's|mulbangul.com/guide-start.html|mulbangul.com/guide/start/|g' \
    -e 's|mulbangul.com/guide-blob.html|mulbangul.com/guide/blob/|g' \
    -e 's|mulbangul.com/guide-unity.html|mulbangul.com/guide/unity/|g' \
    -e 's|mulbangul.com/guide-making.html|mulbangul.com/guide/making/|g' \
    -e 's|mulbangul.com/privacy.html|mulbangul.com/privacy/|g' \
    "$f"
done

echo "3) 옛 주소를 새 주소로 넘겨주는 파일 만드는 중..."
make_redirect () {
  cat > "$1" <<EOF
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>이동 중…</title>
<link rel="canonical" href="https://mulbangul.com$2">
<meta http-equiv="refresh" content="0; url=$2">
<meta name="robots" content="noindex">
</head>
<body><p>새 주소로 이동합니다. <a href="$2">바로 가기</a></p>
<script>location.replace("$2");</script>
</body>
</html>
EOF
}
make_redirect editor.html       /editor/
make_redirect privacy.html      /privacy/
make_redirect guide-start.html  /guide/start/
make_redirect guide-blob.html   /guide/blob/
make_redirect guide-unity.html  /guide/unity/
make_redirect guide-making.html /guide/making/

echo "4) sitemap.xml 새로 쓰는 중..."
TODAY=$(date +%F)
cat > sitemap.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url><loc>https://mulbangul.com/</loc><lastmod>$TODAY</lastmod><priority>1.0</priority></url>
  <url><loc>https://mulbangul.com/editor/</loc><lastmod>$TODAY</lastmod><priority>0.9</priority></url>
  <url><loc>https://mulbangul.com/guide/start/</loc><lastmod>$TODAY</lastmod><priority>0.8</priority></url>
  <url><loc>https://mulbangul.com/guide/blob/</loc><lastmod>$TODAY</lastmod><priority>0.8</priority></url>
  <url><loc>https://mulbangul.com/guide/unity/</loc><lastmod>$TODAY</lastmod><priority>0.8</priority></url>
  <url><loc>https://mulbangul.com/guide/making/</loc><lastmod>$TODAY</lastmod><priority>0.7</priority></url>
</urlset>
EOF

echo
echo "완료. 확인 후 push 하세요."
echo "  git add -A && git commit -m 'URL 정리' && git push"
