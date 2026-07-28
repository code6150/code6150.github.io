# 물방울 — 배포 체크리스트

## 1. 올리기 전에 바꿔야 할 3가지

전체 파일에서 아래 문자열을 찾아 바꾸세요. (VS Code에서 `Ctrl+Shift+F` → 폴더 전체 치환)

| 찾을 것 | 바꿀 것 |
|---|---|
| `your-domain.com` | 실제 도메인 (예: `mulbangul.com`) |
| `your-email@example.com` | 실제 연락용 메일 주소 |
| `ca-pub-0000000000000000` | 애드센스 게시자 ID (승인 신청 시) |

도메인을 아직 안 샀으면 `your-domain.com`은 그대로 둬도 사이트는 정상 작동합니다.
canonical과 sitemap만 안 맞을 뿐이고, 도메인 연결한 뒤에 바꿔도 됩니다.

## 2. GitHub Pages 올리기

```bash
cd mulbangul-site
git init
git add .
git commit -m "물방울 픽셀아트 에디터"
git branch -M main
git remote add origin https://github.com/<계정>/<저장소>.git
git push -u origin main
```

저장소 → Settings → Pages → Source를 `main` / `(root)` 로 지정.
1~2분 뒤 `https://<계정>.github.io/<저장소>/` 에서 열립니다.

## 3. 파일 구조

```
index.html          랜딩 (히어로, 소개, FAQ)
editor.html         에디터 본체
guide-start.html    사용법
guide-blob.html     슬라이더 설명
guide-unity.html    유니티 임포트
guide-making.html   개발기
privacy.html        개인정보처리방침
style.css           랜딩/가이드 공용 스타일 (에디터는 자체 스타일)
ads.txt             승인 후 주석 해제
robots.txt / sitemap.xml
```

## 4. 광고 붙이는 순서

1. 도메인 연결하고 사이트가 정상 작동하는지 확인
2. `your-domain.com`, 메일 주소 치환
3. Google Search Console에 사이트 등록 + sitemap.xml 제출
4. 2~4주 정도 실제 방문자를 만든 뒤 (SNS, 커뮤니티 공유) 애드센스 신청
5. 신청 시 `<head>`의 애드센스 스크립트 pub 번호를 본인 것으로 교체
6. 승인되면 각 페이지의 `<!-- 애드센스 승인 후 주석 해제 -->` 블록을 풀고 slot 번호 입력
7. `ads.txt`의 주석(#)을 지우고 pub 번호 교체

## 5. 승인 전 자가 점검

- [ ] 모든 페이지가 모바일에서 안 깨지는가
- [ ] 깨진 링크가 없는가
- [ ] 개인정보처리방침에 실제 연락처가 들어갔는가
- [ ] 각 가이드 글에 본인이 실제로 겪은 내용이 반영됐는가
- [ ] 대문에서 에디터까지 2클릭 안에 도달하는가
