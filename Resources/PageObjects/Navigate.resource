*** Settings ***
Library     SeleniumLibrary

*** Variables ***
# Locators cho các nút điều hướng trên Header
${BTN_ADMISSION}        xpath://a[contains(text(),'TRA CỨU TUYỂN SINH')]
${BTN_SCHEDULE}         xpath://a[contains(text(),'THỜI KHÓA BIỂU GIẢNG VIÊN')]
${BTN_LOGIN}            xpath:(//a[contains(text(),'Đăng nhập')])[2]

# Các Element đặc trưng để xác nhận đã chuyển trang thành công
${HEADER_ADMISSION}     xpath://h5[contains(text(),'Hệ thống tra cứu kết quả trúng tuyển năm 2025')]
${HEADER_SCHEDULE}      xpath://h5[contains(text(),'Thời khóa biểu')]
${TXT_USERNAME}         name:email    

# Các đoạn URL mong đợi
${URL_ADMISSION}        TraCuuThongTinTuyenSinh
${URL_SCHEDULE}         ThoiKhoaBieuGiangVien
${URL_LOGIN}            login

*** Keywords ***
Navigate To Admission Page
    [Documentation]    Điều hướng và xác nhận đã vào đúng trang tuyển sinh
    Wait Until Element Is Visible    ${BTN_ADMISSION}    15s
    Click Element    ${BTN_ADMISSION}
    # Kiểm tra 1: Element đặc trưng xuất hiện
    Wait Until Element Is Visible    ${HEADER_ADMISSION}    15s
    # Kiểm tra 2: URL chứa từ khóa mong đợi
    ${current_url}=    Get Location
    Should Contain    ${current_url}    ${URL_ADMISSION}

Navigate To Schedule Page
    [Documentation]    Điều hướng và xác nhận đã vào đúng trang Thời khóa biểu giảng viên
    Wait Until Element Is Visible    ${BTN_SCHEDULE}    15s
    Click Element    ${BTN_SCHEDULE}
    # Kiểm tra 1: Tiêu đề "Thời khóa biểu" xuất hiện
    Wait Until Element Is Visible    ${HEADER_SCHEDULE}    15s
    # Kiểm tra 2: URL chuyển sang trang Thời khóa biểu
    ${current_url}=    Get Location
    Should Contain    ${current_url}    ${URL_SCHEDULE}

Navigate To Login Page
    [Documentation]    Điều hướng và xác nhận đã vào đúng trang Đăng nhập
    Wait Until Element Is Visible    ${BTN_LOGIN}    15s
    Click Element    ${BTN_LOGIN}
    # Kiểm tra 1: Ô nhập liệu Username xuất hiện
    Wait Until Element Is Visible    ${TXT_USERNAME}    15s
    # Kiểm tra 2: URL chuyển sang trang Login
    ${current_url}=    Get Location
    Should Contain    ${current_url}    ${URL_LOGIN}

Navigate To Faculty Schedule Page
    [Documentation]    Điều hướng và xác nhận đã vào đúng trang Thời khóa biểu giảng viên
    Wait Until Element Is Visible    ${BTN_SCHEDULE}    15s
    Click Element    ${BTN_SCHEDULE}
    # Kiểm tra 1: Tiêu đề "Thời khóa biểu" xuất hiện
    Wait Until Element Is Visible    ${HEADER_SCHEDULE}    15s
    # Kiểm tra 2: URL chuyển sang đúng trang Thời khóa biểu giảng viên
    ${current_url}=    Get Location
    Should Contain    ${current_url}    ${URL_SCHEDULE}