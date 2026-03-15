*** Settings ***
Documentation     Bộ kiểm thử điều hướng các chức năng chính trên Header trang QNU.
Resource          ../Resources/PageObjects/Common.resource
Resource          ../Resources/PageObjects/Navigate.resource

Test Setup      Mo Trinh Duyet QNU
Test Teardown   Dong Trinh Duyet QNU

*** Test Cases ***
# TC_01: Verify Navigation To Admission Page
#     [Documentation]    Kiểm tra việc chuyển hướng thành công đến trang Tra cứu tuyển sinh
#     [Tags]             Priority_High    UI_Navigation
#     Navigate To Admission Page  

# TC_02: Verify Navigation To Faculty Schedule Page
#     [Documentation]    Kiểm tra việc chuyển hướng thành công đến trang Thời khóa biểu giảng viên
#     [Tags]             Priority_Medium    UI_Navigation
#     Navigate To Schedule Page   

TC_03: Verify Navigation To Login Page
    [Documentation]    Kiểm tra việc chuyển hướng thành công đến trang Đăng nhập
    [Tags]             Priority_High    Authentication
    Navigate To Login Page



