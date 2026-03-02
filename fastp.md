# 次世代定序、生物資訊學與基因體醫學(II)

## 本次課程主要內容
 1. 複製課程檔案至國網中自己的資料夾
 2. sample QC:對原始定序資料進行快速品質控制檢查。通過Quality Control研究人員可以識別資料中的潛在問題，從而做出資料過濾、修正的決定。在高通量定序實驗中，品質控制是對原始定序資料進行檢查和評估的過程，以確保資料的完整性和可靠性。


## 複製課程檔案
> [!CAUTION]
> ‼️因為是將檔案複製至國網，所以以下步驟的指令都需在『你自己的』遠端主機的 `/work/{your_username}` 路徑下 (**請確保現在是在自己的路徑下！！！**)

### step 1 在國網上建立路徑
1. 登入國網（忘記怎麼登入的人請參見[連結](https://hackmd.io/jcvG9iIiRW6DTUysi8AKug)）
2. 進入work資料夾輸入`cd /work/username`，接著輸入`mkdir result`可以在國網主機目前的位置下建立一個叫做result的資料夾，作為本次作業檔案儲存的資料夾
    ```
    cd /work/username
    mkdir result
    ```
3. 接著`cd result`在建立一個資料夾`mkdir fastq`儲存下載的sample
    ```
    cd result
    mkdir fastq
    ```

> [!IMPORTANT]
> #### 命令小學堂
> - `mkdir` make directory，用來在指定位置創建一個新的目錄（資料夾）
> - mkdir 的用法: ```mkdir [選項]   #建立一個新目錄(資料夾)```

4. 在terminal利用`rsync`指令，將分析所需的指令(bash檔)，複製到自己的路徑下使用\
    **❗此步驟你需要學會如何從國網別人的資料夾中複製檔案到自己在國網的資料夾❗**
    ```
    rsync -avz /work/evelyn92/2026NGS/HW1/fastp.sh ./
    ```

5. 另外[下載](http://gofile.me/52bBz/zExe2bPaf)分析所需資料
    ```
    #下載密碼:BioInfo11532
    #存放檔案的資料夾:NGS_HW
    ```
   >❗ **請下載以下六個檔案!!** (6條reads，共包含三個sample) \
   > SRR13076392_1.fastq.gz \
   > SRR13076392_2.fastq.gz \
   > SRR13076393_1.fastq.gz \
   > SRR13076393_2.fastq.gz \
   > SRR13076398_1.fastq.gz \
   > SRR13076398_2.fastq.gz
   
6. 請直接[上傳](https://github.com/Jacob-s-Lab/2026_NGS/blob/main/Linux_NCHC.md)  檔案到fastq\
    **❗此步驟需要學習的內容為將檔案從本地端上傳至國網❗**
    ```
    上傳檔案:rsync -azrvh . 主機帳號@t3-c4.nchc.org.tw:/work/主機帳號/result/fastq
    解壓縮檔案: unzip <要解壓縮的檔名>
    改檔名: mv <原本的檔名> <後來的檔名>
    ```

> [!CAUTION]
> `fastq`：此**資料夾**存放<ins> 下載的檔案 (fastq檔案) </ins>

> [!IMPORTANT]
> #### 文件格式介紹
> - `fastq` : FASTQ 是一種文件格式，用於存儲生物學領域中高通量定序技術生成的 DNA 或 RNA 序列資料。這種格式同時包含了序列的核苷酸序列和對應的品質分數
> - `fastp.sh` : 此**檔案**為執行分析所需的執行檔
     
---------------

# Sample QC
Shell script for running [fastp](https://github.com/Jacob-s-Lab/2026_NGS/blob/main/script/fastp.sh).

## Step 1 建立shell script

> [!IMPORTANT]
> #### 甚麼是shell script?
> shell  script(程式化草稿)
> - 簡單來說，是利用 shell 的功能所寫的一個『程式 (program)』，這個程式是使用純文字檔，將一些 shell 的語法與指令(含外部指令)寫在裡面， 搭配正規表示法、管線命令與資料流重導向等功能，以達到我們所想要的處理目的，通過編寫和使用 Shell 草稿，可以提高工作效率並減少重複操作命令
> - 可在 Unix、Linux 或其他類 Unix 系統的 shell 環境中運行。最常用的 shell 草稿語言包括 Bash（Bourne Again Shell）、Sh（Bourne Shell）和 Zsh（Z Shell）。

> reference:https://linux.vbird.org/linux_basic/centos7/0340bashshell-scripts.php#script

 
1. 進入result資料夾，輸入`cd /work/username/result`
2. 進入shell script，輸入`vim fastp.sh`

> [!IMPORTANT]
> #### 命令小學堂
> - 在 Unix 和 Linux 系統中，命令 `vim fastp.sh` 用於使用 Vim 編輯器打開或創建名為 `fastp.sh` 的文件。這是一個簡單的命令，用於進入 Vim 編輯器以編輯指定的 Shell Script 文件。
> - 具體含義
>  * vim：這是命令行文本編輯器 Vim 的名稱。Vim 是一個強大的文本編輯器，廣泛用於編輯程序代碼和草稿。
>  * `fastp.sh`：這是要編輯的文件名。在這種情況下，`fastp.sh` 是一個 Shell Script 文件，擴展名 .sh 通常表示這是一個 Shell 脚本文件。
> - 執行該命令後的行為：
>  * 如果 `fastp.sh` 文件已經存在，`vim fastp.sh` 會打開這個文件，允許你查看和編輯其內容。
>  * 如果 `fastp.sh` 文件不存在，`vim fastp.sh` 會創建一個新的空文件，並進入 Vim 編輯器以便你可以開始編寫草稿。

  
3. 請按鍵盤 <kbd>i</kbd> 進入編輯模式 (底下會出現"–- INSERT –-")，並把上一步驟下載的shell scipt 貼到`fastp.sh`


## Step 2 修改分析執行檔

1. 請更改以下程式碼：
> 以下示範會以fastq資料夾中的SEA做為示範 (格式請依照裡面給你的範例，副檔名不用寫進去)
> 

(1) Slurm排程設定

> [!IMPORTANT]
> #### slurm是甚麼?
> SLURM（Simple Linux Utility for Resource Management）是一個用於大規模計算集群的開源資源管理器和工作負載管理器。它主要用於高性能計算（HPC）環境，幫助管理和調度計算資源，如 CPU、內存和計算節點。SLURM 在大型超算中心、研究機構和企業中廣泛使用。


  👉 接下來依照指示修改這個區塊 (請見下面說明)：

  ```
  #!/usr/bin/sh
  #SBATCH -A ACD114093                      # Account name/project number
  #SBATCH -J fastp                          # Job name
  #SBATCH -p ngscourse                      # Partition Name 等同PBS裡面的 -q Queue name
  #SBATCH -c 2                              # 使用的core數 請參考Queue資源設定
  #SBATCH --mem=13g                         # 使用的記憶體量 請參考Queue資源設定
  #SBATCH -o out.log                        # Path to the standard output file
  #SBATCH -e err.log                        # Path to the standard error ouput file
  #SBATCH --mail-user=yourmail@gmail.com    # email
  #SBATCH --mail-type=END                   # 指定送出email時機 可為NONE, BEGIN, END, FAIL, REQUEUE, ALL
  ```

(2) 修改檔案路徑  
  ```
  # Please enter the R1 & R2 file name and your username
  user=username                        # 國網帳號               
  IN_DIR=/work/${user}/result/fastq    # 存放fastq的資料夾路徑
  sample=SRR13076392                   # sample的名稱
  R1=${IN_DIR}/${sample}_1.fastq.gz    # R1所在的檔案路徑
  R2=${IN_DIR}/${sample}_2.fastq.gz    # R2所在的檔案路徑
  ```

(3)建立資料夾(命名為`fastp_${sample}`)來存放fastp結果
  ```
  # output
  OUT_DIR=/work/${user}/result/fastp_${sample}
  mkdir -p ${OUT_DIR}
  ```
    
(4) 修改執行fastp的命令
  ```
  fastp \
  -i ${R1} -I ${R2} \
  -o ${OUT1} -O ${OUT2} \
  -h ${HTML} -j ${JSON} \
  -w 3
  ```
(5)按 <kbd>Esc</kbd> 離開編輯模式  
(6) 輸入 `:wq` 並按下 <kbd>Enter</kbd> 可儲存結果  
**❗若出現 "E45: 'readonly' option is set (add ! to override)" 的話，請輸入`:wq!`來儲存）❗**

> [!IMPORTANT]
> #### 命令小學堂
> - ```:wq```: 保存並退出    
> 是在 Vim 編輯器中用來保存文件並退出編輯模式的命令，先按 ```Esc``` 進入命令模式，然後輸入 ```:wq``` 並按下 Enter。這將會保存當前文件的修改並退出 Vim。 ```w``` 代表 write（保存）， ```q``` 代表 quit（退出）
> - ```:wq!```: 強制保存並退出    
> 如果文件是只讀的或者有其他限制，可以使用 ```:wq!``` 來強制保存並退出。 ```!``` 是強制執行的意思
> - 如果你只想保存文件但不退出，可以使用 ```:w```，如果只想退出但不保存，可以使用 ```:q``` 或 ```:q!``` (強制退出)。

2. 執行script

(1)輸入以下指令，來以sbatch job的方式送出編輯完成的草稿
```
sbatch fastp.sh
```


> [!IMPORTANT]
> #### 命令小學堂
> ```sbatch``` 是 SLURM 的一個命令行工具，用於提交作業草稿到 SLURM 作業調度系統。這些草稿通常包含 SLURM 指令和要執行的命令。

(2)若送出成功將會出現以下文字(結果在result資料夾已經指定好路徑)
```
Submitted batch job ＿＿＿
```

(3)可使用以下指令查看工作執行情況
```
sacct
```
![image](https://hackmd.io/_uploads/Sk5iLyfYZl.png)


> [!IMPORTANT]
> #### 命令小學堂
> ``sacct`` 此指令用於列出帳號的相關任務或任務集之狀態，例如運行中、已終止或是已完成，是最基本的檢視任務指令。它可以顯示例如ID、使用者、狀態、使用的資源等資訊，這個命令對於追蹤和分析作業的運行情況非常有用。

3. 查看結果  
 `out.log`和`err.log`為執行這個script的標準輸出和標準錯誤，如果執行時有出現錯誤，可以查看`err.log`(檔案會在`/work/username/result/`底下)
* 這份執行檔會產生html檔（檔名為`sample.html`)，下載後即可開啟查看fastp Report
* 下載詳情可見連結[下載](https://github.com/Jacob-s-Lab/2026_NGS/blob/main/Linux_NCHC.md)
  

