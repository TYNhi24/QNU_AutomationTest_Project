*** Settings ***
Resource    ../Resources/PageObjects/Common.resource
Resource    ../Resources/PageObjects/Navigate.resource
Resource    ../Resources/PageObjects/LoginPage.resource

Test Setup       Run Keywords    Mo Trinh Duyet QNU    AND    Navigate To Login Page
Test Teardown    Dong Trinh Duyet QNU

*** Test Cases ***
TC-021: Verify Successful Login With Valid Credentials
    [Documentation]    Kiểm tra đăng nhập thành công với tài khoản đúng
    [Tags]             Priority_High    Smoke_Test
    Login To System    4551050152    1521050455
    Verify Login Success

TC-022: Verify Error Message When Username Is Empty
    [Documentation]    Kiểm tra lỗi khi không nhập tên đăng nhập
    Login To System    ${EMPTY}      1521050455
    Verify Login Error Message    ${MSG_MISSING_USER}

TC-023: Verify Error Message When Password Is Empty
    [Documentation]    Kiểm tra lỗi khi không nhập mật khẩu
    Login To System    4551050152    ${EMPTY}
    Verify Login Error Message    ${MSG_MISSING_PASS}

TC-024: Verify Error Message For Invalid Username
    [Documentation]    Kiểm tra lỗi khi nhập sai tài khoản 
    Login To System    wrong_user    1521050455
    Verify Login Error Message    ${MSG_INVALID_AUTH}

TC-025: Verify Error Message For Invalid Password
    [Documentation]    Kiểm tra lỗi khi nhập sai mật khẩu
    Login To System    4551050152    wrong_pass
    Verify Login Error Message    ${MSG_INVALID_AUTH}
TC-026: Verify Error Message For Both Username And Password Empty
    [Documentation]    Kiểm tra lỗi khi không nhập cả tên đăng nhập và mật khẩu
    Login To System    ${EMPTY}      ${EMPTY}
    Verify Both Fields Required