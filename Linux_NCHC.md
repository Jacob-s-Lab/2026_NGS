# 次世代定序、生物資訊學與基因體醫學(I)


## 本次課程主要內容
1. 國網註冊及登入：[填寫國網帳號調查](https://forms.gle/gMknPEFekTxtZwmb7)
2. Thinlinc下載並連結國網
3. 上傳檔案至國網及至國網下載檔案


## 工具概述
1. iServer（網站）：用於建立伺服器帳號，並啟用 OTP（一次性密碼）功能來保護帳號安全
2. Terminal開啟終端機（macOS）或CMD命令列（Windows）：從本地電腦遠端登入伺服器或超級電腦，進行指令操作
3. ThinLinc（local 軟體）：用於透過圖形化介面遠端操作伺服器，適合處理需要桌面環境的工作
4. rsync（macOS 工具）或 WinSCP（Windows 軟體）：在本地與伺服器之間傳輸與管理檔案


## step 1:國網操作與設定
### 前言
> 這是一份國網註冊及登入的教學指南，請按照以下步驟逐一操作

### 註冊iservice帳號
1. 進入iservice介面：https://iservice.nchc.org.tw/nchc_service/index.php?lang_type=
2. 點選畫面右上角的"註冊"       
![image](https://hackmd.io/_uploads/B1VWT7Q36.png)      
3. 閱讀並同意iService會員註冊及服務使用條款
4. 請輸入預計註冊的iservice帳號
(注意：這裡的iservice帳號**只是用來登入iservice網站(非主機！)用的**)
5. 依序填寫**會員資料**、**主機帳號資料** 
(注意：一支手機號碼只能申請一個帳號)
(注意：請記下你用來註冊的信箱＆密碼(用來登入**iservice網站**)、記下你的主機帳號＆密碼(用來登入及操作**國網主機**))      
![image](https://hackmd.io/_uploads/BJF9JVXhp.png)     
6. 依照指示完成驗證
(注意：會員註冊確認信會寄送到你用來註冊的信箱、註冊授權碼會寄送到手機簡訊)

### 登入iservice帳號
1. 進入iservice介面：https://iservice.nchc.org.tw/nchc_service/index.php?lang_type=
2. 點選畫面右上角的"登入"     
![image](https://hackmd.io/_uploads/B1VWT7Q36.png)     
3. 依序點選畫面上方的：會員中心->會員資訊->主機帳號資訊
![image](https://hackmd.io/_uploads/SJ9ou4mhp.png)

A. 注意你的主機帳號旁邊是否有註記"啟用"，若沒有請注意[註冊iservice帳號](##註冊iservice帳號)是否有完成驗證步驟      
![image](https://hackmd.io/_uploads/SkgBlY4X2a.png)      
(注意：若有需要可自行定期更改主機密碼)     
B. 請點選"建立OTP載具"，並到當時註冊的信箱中收取"載具註冊通知信"      
![image](https://hackmd.io/_uploads/HyoL8V736.png)      
C. 依據信件中的指示安裝『IDExpert』APP』並完成綁定手機      

*更詳細的[取得OTP認證碼](https://iservice.nchc.org.tw/nchc_service/nchc_service_qa_single.php?qa_code=774)步驟請參考連結文章

### 加入計畫
1. 進入iservice網頁後，依序點選畫面上方的：會員中心->計畫管理->我的計畫
![image](https://hackmd.io/_uploads/r1Gk54Xh6.png)
2. 請填寫表單[國網帳號調查](https://forms.gle/gMknPEFekTxtZwmb7)
3. 完成表單後，**敬請等待**助教們將您的帳號加入本課程「2026 次世代定序、生物資訊學與基因體醫學」的計畫中

### 登入國網
* 使用Windows的同學開啟命令題字元(CMD)      
![image](https://hackmd.io/_uploads/B1gdIdEnC.png)      

* 使用Mac的同學開啟終端機 (terminal)      
![](https://hackmd.io/_uploads/H1K5YKDna.png)      

1. 在CMD(或terminal)中打上`ssh 主機帳號@t3-c4.nchc.org.tw`登入國網生醫節點
> [!IMPORTANT]
> #### 命令小學堂
> - `ssh`:登錄到遠程伺服器
> - 用法:`ssh user@hostname`
> - `user` 你在遠程伺服器上的用戶名，'hostname' 是遠程伺服器的 IP 地址或主機名。
>  
> ⚠️ `t3-c4.nchc.org.tw`為生醫節點。另外，第一次登入節點時會出現 "Are you sure you want to continue connecting (yes/no/[fingerprint])?"，請輸入 `yes`。

- 終端機畫面：
![](https://hackmd.io/_uploads/BkvbPN7ha.png)
- Windows畫面：
![image](https://hackmd.io/_uploads/Hk-LvdVhC.png)

2. 輸入兩階段驗證方式（**不是主機密碼**），若兩階段驗證方式選擇1或3，需要輸入OTP
3. 輸入主機密碼(不是登入iservice的密碼)，輸入密碼時密碼沒有出現在螢幕上是正常的
4. 輸入OTP

> [!CAUTION]
> ‼️注意是先輸入主機密碼，再輸入OTP，不要輸反了

5.登入成功則可以看到以下畫面
![](https://hackmd.io/_uploads/S1H454mha.png)


## step 2:下載 Thinklinc
### 下載Thinlinc
1. 下載需要用到的軟體：Thinlinc
- 在[thinlinc官網](https://www.cendio.com/thinlinc/download/)下載您的電腦相對應的版本並安裝即可
![截圖 2024-06-24 上午10.06.36](https://hackmd.io/_uploads/HJq3EUI80.png)

2. [國網OTP是否已啟用](###登入國網)

### 使用Thinlinc登入國網、進入遠端主機、開啟終端機 (terminal)
> [!CAUTION]
> 依照以下步驟仍無法登入時，請先確認：
> > (1) 如果出現Permission denied (keyboard-interaction)，請確認當時是否有填寫老師給你的表單，如果沒有請立馬填寫、通知助教\
> > (2) 是否有到iservice網站啟用OTP認證\      
> > (3) 登入時，輸入的東西順序是否正確\      
> > (4) 主機帳號密碼是否輸錯 (注意：跟iservice帳號密碼不一樣)\     
> > (5) 釐清大小寫/中英切換/全形半形字切換問題 (Mac使用者更需注意)\
>        
> **若上述問題都排除後，仍無法登入，請通知老師or助教，千萬不要硬登！會被鎖起來！！！**   
  
- Thinlinc登入畫面如下      
  ![](https://i.imgur.com/XvGJFXA.png)

1. 請在server輸入登入節點`t3-c4.nchc.org.tw`
2. 請在username 輸入「國網主機帳號」
3. 請在password 輸入「**1**」，再按 enter 登入 
(**注意：這裡不是輸入主機密碼、不是iservice密碼！！！**)
4. 請輸入「國網主機密碼」 (**注意：是輸入主機密碼、不是iservice密碼！！！**)
    ![](https://hackmd.io/_uploads/SyNwc58I0.png)
5. 手機app取得OTP 
     請在此輸入剛剛取得的 OTP (**不是主機密碼！！！不是iservice密碼！！！**)
    ![image](https://hackmd.io/_uploads/ByOlnc88A.png)
6. 成功登入後，請點選 「Forward」、「OK」
   ![image](https://hackmd.io/_uploads/Bygem38LR.png)
   ![image](https://hackmd.io/_uploads/HksxQ3L8C.png)

7. 登入之後，點選左上角 Activitives 後會看到左邊出現九個點 (Show Applications)，點進去之後，選擇 Xfce Terminal
   ![image](https://hackmd.io/_uploads/SyT2p5I80.png)
   
    **小提醒：如果過一陣子沒有使用，系統會自動跳出，這時候再重新操作登入流程**
   
### 進入遠端主機的資料夾`/work`

1. 在terminal利用`cd`指令，進入自己的主機、位於`/work`路徑下的空間

```
cd /work/{your_username}
```

2. 使用`pwd`可查看所在位置是否正確

> [!IMPORTANT]
> #### 命令小學堂
> ``cd`` 是命令列工具中的一個常用指令，全稱為 change directory，用來在終端或命令列中切換當前工作目錄
> `cd`的用法:
> ```
> cd [目錄路徑] #切換到指定目錄
> cd ..        #返回上一級目錄
> cd ~         #回到使用者主目錄
> cd           #直接使用，會將當前目錄切換回使用者的主目錄
> cd -         #這會將當前目錄切換到上一次使用的目錄
> ```
>
> * ⚠️ **指令跟路徑之間有"空白"，不要輸成"cd/work/{your_username}"**，後面的程式碼也是一樣
>    * 小技巧：用滑鼠選取、確認一下有無空白\
> * ⚠️ **如果直接複製指令碼、記得看一下是否有要改的地方！！！**\
> * ⚠️ **請將 `{your_username}` 整個改成你的主機帳號，不要把"{}"也打入！也請不要把"/"刪掉！** 後面的程式碼也是一樣

> [!IMPORTANT]
> #### 命令小學堂
> ``pwd``print working directory，用來顯示當前所在的工作目錄的完整路徑，特別是在多層目錄中工作時，可以隨時查看當前的位置


## step 3:檔案資料傳輸
### 上傳/下載檔案

- 使用Mac的同學可使用終端機並搭配[rsync指令上傳](#使用rsync上傳檔案)/[下載](#使用rsync下載檔案)
- 使用Windows的同學可使用 [WinSCP上傳](###使用WinSCP上傳檔案)/[下載](###使用WinSCP下載檔案)

-----------------------------

### 使用rsync上傳檔案
1. 首先，先確認你自己的電腦，你要上傳的3個檔案是否統一放在一個獨立的資料夾(千萬不要放到本機電腦的desktop or download，不然依照後面的步驟會把所有在資料夾的檔案全部上傳喔)
![image](https://hackmd.io/_uploads/S1wxNLmpp.png)
2. 開啟**本機端的**終端機 (**注意，要另外開一個終端機，不是你現在有登入國網主機的終端機！**)
![image](https://hackmd.io/_uploads/Bk3Q4L7pp.png)

3. "cd"到你要上傳的資料夾位置（資料夾位置的部分，可用滑鼠拖曳的方式將資料夾拉到終端機指令區，即可快速輸入資料夾位置）
![image](https://hackmd.io/_uploads/HyrRNL7aa.png)
（附註：『Mac如何在finder顯示檔案或檔案夾的路徑位置』可參見[macOS 使用手冊](https://support.apple.com/zh-tw/guide/mac-help/mchlp1774/mac)）
![image](https://hackmd.io/_uploads/Hk3bBUmaT.png)


4. 使用以下指令將本機資料夾中的檔案上傳到`/home/主機帳號/HW1`下 (請自行將主機帳號替換成自己的)
    ```
    rsync -azrvh . 主機帳號@t3-c4.nchc.org.tw:/home/主機帳號/HW1
    ```
> [!IMPORTANT]
> #### 命令小學堂
> - `rsync`：這是用來同步文件和目錄的命令工具
> - `-azrvh`:
>  1. -a：歸檔模式。這是一個選項組合，保留文件的結構和屬性。確保符號鏈接、設備、屬性、權限、所有權和時間戳被保留。基本上，它會嘗試創建源文件的精確副本。
>  2. -z：在傳輸過程中壓縮文件數據。這個選項會在數據傳輸過程中進行壓縮，以減少需要通過網絡或在位置之間傳輸的數據量。
>  3. -r：遞歸。這個選項告訴 rsync 以遞歸方式複製目錄。當你想同步目錄及其內容時，這個選項是必要的。
>  4. -v：詳細模式。這個選項增加了輸出的詳細程度，提供更多有關 rsync 在同步過程中正在做什麼的信息。它顯示有關正在傳輸的文件和其他相關操作的詳細信息。
>  5. -h：人類可讀。這個選項使輸出更易於閱讀，將文件大小轉換為更友好的格式（例如 KB、MB），而不是顯示原始字節大小。
>  6. "."：這表示源目錄。在這種情況下，它意味著當前目錄。rsync 會將當前目錄的內容同步到指定的目標位置（在這個命令中目標位置缺失）。
>
> ⚠️ 如果你在國網上建的資料夾名稱不是 "HW1" 的話，請根據你的資料夾名稱更改\
     （附註："."代表你現在資料夾所在的位置）\
> ⚠️**檔案與 "." 之間需空一格**）\
     （附註，檔案比較大，可能會上傳很久，可以打坐冥想）

5. 依序輸入**兩階段驗證方式**、**主機密碼** 與 **OTP**（若兩階段驗證方式選擇1或3才需要) 後就會將資料夾中的檔案開始上傳

### 使用rsync下載檔案

1. 開啟**本機端的**終端機並`cd`到**檔案要下載到的位置**（可用滑鼠拖曳的方式將資料夾位置輸入到終端機中）
(**注意，要另外開一個終端機，不是你現在有登入國網主機的終端機！**)
![](https://hackmd.io/_uploads/HJ2t2Aq2a.png)

2. 使用以下指令將國網上的檔案下載到本機端當前路徑
    ```
    rsync -azvh 主機帳號@t3-c4.nchc.org.tw:檔案路徑 .
    ```
    若需要下載的為**資料夾**，則須在前面的指令改為`rsync -azrvh`
    （注意：**檔案與 "." 之間需空一格**）
3. 依序輸入 **1、主機密碼與OTP** 後就會開始下載，下載完成後即可從本地端開啟檔案

-----------------------------

### 使用WinSCP上傳檔案
1. 若沒安裝WinSCP的同學，請至[此網址](https://winscp.net/download/WinSCP-6.5.3-Setup.exe/download)點選 **Direct Download** 下載
![螢幕擷取畫面 2025-08-13 144230](https://hackmd.io/_uploads/SkgMA6gcex.png)
2. 依序點選 **接受** -> **下一步** -> **下一步** -> **安裝**，出現以下畫面後按完成即完成安裝
![螢幕擷取畫面 2025-08-13 145649](https://hackmd.io/_uploads/Sysw0Te9xl.png)
3. 開啟WinSCP
![image](https://hackmd.io/_uploads/SySMJpKOll.png)
4. 依照以下畫面填入或更改選項
![螢幕擷取畫面 2025-08-13 153246](https://hackmd.io/_uploads/HkYnkTY_gl.png)
   ```
   檔案協定:SFTP
   主機名稱: t3-c4.nchc.org.tw
   使用者名稱: 你的國網帳號名稱
   密碼: 你的主機密碼
   ```
5. 更改完成後按下**儲存** -> **確定** -> **登入** -> **接受**，並在跳出的視窗依序輸入 ：**1** -> **主機密碼** -> **OTP** 
6. 連線成功後，如下圖所示，左半部是你的本機空間與路徑，右半部是你的國網空間與路徑
![螢幕擷取畫面 2025-08-13 154157](https://hackmd.io/_uploads/ry9rY29_ee.png)
7. 請在右半部"遠端站台"處，改成檔案所在路徑(用意是要將檔案上傳到這個路徑下)  \
![螢幕擷取畫面 2025-08-14 090839](https://hackmd.io/_uploads/Sk0j5h5_lx.png)  \
![螢幕擷取畫面 2025-08-14 090917](https://hackmd.io/_uploads/rkUCqnq_gx.png)
9. 在左半部(本機空間)選取要上傳的檔案，拖移到右半部(國網空間)即可將檔案上傳至國網

### 使用WinSCP下載檔案
1. 請依照前面[上傳檔案](###使用WinSCP上傳檔案)進行連線
2. 在左半部先移動到檔案要下載到的資料夾下 (注意：避免到時候檔案下載到你不知道的地方去)
3. 在右半部(國網主機空間)選取要下載的檔案，按右鍵選擇下載即可將檔案下載(檔案放的位置就在你左半部顯示的資料夾路徑下)
![螢幕擷取畫面 2025-08-14 093039](https://hackmd.io/_uploads/HkGIhn5del.png)  \
(**注意：若想要開啟檔案，請不要直接在WinSCP的本地站台點開，請回到你的電腦桌面點選剛剛儲存的路徑再去打開檔案，若直接從WinSCP的本地站台點選檔名，將會把檔案上傳到國網**）

-----------------------------
