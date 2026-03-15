*** Settings ***
Resource    ../Resources/PageObjects/Common.resource
Resource    ../Resources/PageObjects/Navigate.resource
Resource    ../Resources/PageObjects/LoginPage.resource

Test Setup       Run Keywords    Mo Trinh Duyet QNU    AND    Navigate To Login Page
Test Teardown    Dong Trinh Duyet QNU

*** Test Cases ***
TC-001: Verify Successful Login With Valid Credentials
    [Documentation]    Kiểm tra đăng nhập thành công với tài khoản đúng
    [Tags]             Priority_High    Smoke_Test
    Login To System    4551050152    1521050455
    Verify Login Success

TC-002: Verify Error Message When Username Is Empty
    [Documentation]    Kiểm tra lỗi khi không nhập tên đăng nhập
    Login To System    ${EMPTY}      1521050455
    Verify Login Error Message    ${MSG_MISSING_USER}

TC-003: Verify Error Message When Password Is Empty
    [Documentation]    Kiểm tra lỗi khi không nhập mật khẩu
    Login To System    4551050152    ${EMPTY}
    Verify Login Error Message    ${MSG_MISSING_PASS}

TC-004: Verify Error Message For Invalid Credentials
    [Documentation]    Kiểm tra lỗi khi nhập sai tài khoản hoặc mật khẩu
    Login To System    wrong_user    wrong_pass
    Verify Login Error Message    ${MSG_INVALID_AUTH}