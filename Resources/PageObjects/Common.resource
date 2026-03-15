*** Settings ***
# Thêm tham số run_on_failure=None để tắt tính năng chụp ảnh mặc định của SeleniumLibrary
Library    SeleniumLibrary    run_on_failure=None

*** Variables ***
${BROWSER}    chrome
${URL_QNU}    https://daotao.qnu.edu.vn

*** Keywords ***
Mo Trinh Duyet QNU
    Open Browser    ${URL_QNU}    ${BROWSER}
    Maximize Browser Window
    # Dòng này giúp ép tất cả ảnh chụp màn hình vào folder mong muốn
    Set Screenshot Directory    Results/screenshots
Dong Trinh Duyet QNU
    # Tự động chụp ảnh nếu Test Case bị thất bại trước khi đóng trình duyệt
    Run Keyword If Test Failed    Thuc Hien Chup Anh Loi
    Close Browser
Thuc Hien Chup Anh Loi
    Sleep    2s
    ${clean_name}=    Evaluate    '${TEST_NAME}'.replace(':', '')
    Capture Page Screenshot    ${clean_name}_failure.png