# live-dl Service on Docker + 磁碟滿時自動清理錄影
> 這是從屬於 [jim60105/docker-ReverseProxy](https://github.com/jim60105/docker-ReverseProxy) 的 live-dl 方案，必須在上述伺服器運行正常後再做

**請參考 [琳的備忘手札 Youtube直播錄影伺服器建置](https://blog.maki0419.com/2020/11/docker-youtube-dl-auto-recording-live-dl.html)**

本文希望建置起能永久自動運作的Youtube直播備份機\
此專案目標定位為「錄影備份」，在發生直播主事後砍檔/砍歌時，我才會到伺服器尋找備份\
是故，本專案不著重在錄影後的檔案處理，而是在磁碟滿時做自動刪檔

## 架構
WWW\
│\
nginx Server (Reverse Proxy) (SSL證書申請、Renew)\
├ Jobber (Cron) (定時檢查磁碟使用率，在高於設定之百分比時，自動由舊起刪除錄影)\
├ live-dl (直播監控錄影機)\
└ youtube-dl-server (WebUI下載器)

## 說明
* 錄影和下載會儲存在主機的 `../YoutubeRecordings/` 之下，可以在 [docker-compose.yml](docker-compose.yml)修改
* 可以在錄影完成後執行callback bash script
* Jobber會在每日的01:00 UTC檢查磁碟使用率，並由舊檔案刪起，直到磁碟使用率降到設定值(或直到沒有檔案)

## 部屬
> **本專案有submodule**\
> 如果想要build docker image，請用`git pull --recurse-submodules`
 
* 請參考 [`.env_sample`](.env_sample) 建立 `.env`
    * `LETSENCRYPT_EMAIL`=你的email
    * `HOST`=WebUI網址
    * `DelPercentage`=要執行刪除功能的磁碟使用百分比
* 請編輯 [`config_live-dl.yml`](config_live-dl.yml) 在map處建立名稱表，**此表用於自動錄播時的資料夾建立**
    ```yml
    - name: 久遠たま
      youtube: https://www.youtube.com/channel/UCBC7vYFNQoGPupe5NxPG4Bw
    ```
* 請參考 [`Monitor/tama.sh`](Monitor/tama.sh) 建立要自動錄播的頻道，所有Monitor下的檔案都會被執行
```sh
nohup /bin/bash live-dl {{Youtube URL}} &>/youtube-dl/logs/live-dl-{{Channel Name}}.$(date +%d%b%y-%H%M%S).log &
```
* 給*.sh執行權限 `find ./ -type f -iname "*.sh" -exec chmod +x {} \;`
* 正式發佈前移除 `.env` 中的 `LETSENCRYPT_TEST=true`\
此設定為SSL測試證書\
正式版有申請次數上限，務必在測試正常、最後上線前再移除

## 下載會員限定影片
youtube-dl支援以cookie的方式登入，可以下載會限影片
> youtube-dl的帳密功能**目前確定是壞的**，只能以cookies方式登入\
> 此cookies file包含了你的Youtube登入授權，請務必妥善保管
* 安裝瀏覧器擴充功能，以匯出Netscape HTTP Cookie File
    * Chrome: [Get cookies.txt](https://chrome.google.com/webstore/detail/get-cookiestxt/bgaddhkoddajcdgocldbbfleckgcbcid)
    * Firefox: [cookies.txt](https://addons.mozilla.org/zh-TW/firefox/addon/cookies-txt/)
* 瀏覧至Youtube網頁，登入你的帳號
* 以擴充功能匯出`youtube.com`網域的所有cookie
* 將匯出之cookie檔案重命名為`cookies.txt`
* 取代專案根目錄下的[cookies.txt](cookies.txt)檔，或用於docker run時的volume bind

## 錄影完成Callback
如果需要在下載完成後回呼，請修改[docker-compose.yml](docker-compose.yml)，將回呼腳本bind至livedl之下的/usr/src/app/callback.sh
> 本專案提供的 [download_again.sh](download_again.sh) ，能在下載完成後等待一分鐘，再下載第二次\
> 由於串流中錄影容易有漏秒，所以在「直播結束後至Youtube版權砲前」再下載一次

### callback.sh傳入之參數:
```bash
__info "Calling callback function..."
local cmd=( "$CALLBACK_EXEC" "${OUTPUT_PATH}.mp4" "$BASE_DIR/" "$VIDEO_ID" "$FULLTITLE" "$UPLOADER" "$UPLOAD_DATE" )
nohup "${cmd[@]}" &>> "$OUTPUT_PATH.log" &
```
bash參數
1. 產出檔案的完整路徑
1. 產出檔案之所在資料夾
1. 影片id
1. 影片標題
1. 影片上傳者
1. 上傳日期