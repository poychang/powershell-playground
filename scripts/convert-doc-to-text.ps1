<#
此範例程式碼示範如何透過 Microsoft Word 將 DOC 檔案轉換為 TXT 檔案
使用前先修改 $sourceDirectory 和 $outputDirectory 變數的值
並且設定要轉換的格式，此範例程式預設為 TXT 格式，可以自行從下列清單中選擇
#>

# Word 指定儲存文件時使用的格式清單
# 來源: https://learn.microsoft.com/en-us/office/vba/api/Word.WdSaveFormat
$wdFormat = @{
    'Document'          = 0 # Microsoft Office Word 97 - 2003 binary file format
    'Template'          = 1 # Word 97 - 2003 template format
    'Text'              = 2 # Microsoft Windows text format
    'TextLineBreaks'    = 3 # 
    'DOSText'           = 4 # Microsoft DOS text format
    'DOSTextLineBreaks' = 5 # Microsoft DOS text with line breaks preserved
    'RTF'               = 6 # Rich text format (RTF)
    'EncodedText'       = 7 # Encoded text format
    'HTML'              = 8 # Standard HTML format
    'WebArchive'        = 9 # Web archive format
    'FilteredHtml'      = 10 # Filtered HTML format
    'XML'               = 11 # Extensible Markup Language (XML) format
    'XMLDocument'       = 12 # XML document format
    'Default'           = 16 # Word default document file format. For Word, this is the DOCX format
    'PDF'               = 17 # PDF format
    'XPS'               = 18 # XML template format
    'OpenDocument'      = 23 # OpenDocument Text format
}

# 建立 Word 應用程式物件
$word = New-Object -ComObject Word.Application
$word.Visible = $false

# 設定 DOC 檔案的目錄路徑
$docDirectory = "C:\Path\To\Your\Docs"

# 設定輸出 TXT 檔案的目錄路徑
$txtDirectory = "C:\Path\To\Your\Output"

# 取得 DOC 檔案清單
$docFiles = Get-ChildItem -Path $sourceDirectory -Filter "*.doc" -File

# 迴圈處理每個 DOC 檔案
foreach ($docFile in $docFiles) {
    # 建立 DOC 檔案的完整路徑
    $docPath = [System.IO.Path]::Combine($sourceDirectory, $docFile)
    
    # 建立輸出 TXT 檔案的完整路徑
    $txtPath = [System.IO.Path]::Combine($outputDirectory, $docFile.BaseName + ".txt")
    Write-Host $txtPath

    # 載入 DOC 檔案
    $document = $word.Documents.Open($docPath)

    # # 將 DOC 檔案另存為 TXT 格式
    $WdSaveFormat = $wdFormat.Item('Text')
    $document.SaveAs([ref] $txtPath, [ref]$WdSaveFormat, [Type]::Missing, [Type]::Missing, $false, "65001")

    # # 關閉文件
    $document.Close()
}

# 退出 Word 應用程式並釋放資源
$word.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($word) | Out-Null
Remove-Variable word

Write-Host "批次處理完成。TXT 檔案已輸出至: $outputDirectory"
