const http = require("http");

// 🔴 改成你要用的「線上安卓拖車」網址
const ANDROID_URL = "https://myandroid.org/";

const server = http.createServer((req, res) => {
  res.writeHead(302, {
    Location: ANDROID_URL,
    "Cache-Control": "no-store"
  });
  res.end();
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
  console.log("HTTP redirect server running on port", PORT);
});
