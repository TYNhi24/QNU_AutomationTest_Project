*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${TXT_USERNAME}             name:email
${TXT_PASSWORD}             name:password
${BTN_SUBMIT}               xpath://button[@type='submit']

# Locators cho Assertion
${LBL_SUCCESS_STUDENT}      xpath://a[@href='/student']
${MSG_MISSING_USER}         xpath://p[text()='Tên đăng nhập là bắt buộc']
${MSG_MISSING_PASS}         xpath://p[text()='Mật khẩu là bắt buộc']
${MSG_INVALID_AUTH}         xpath://p[contains(text(),'Tên đăng nhập hoặc mật khẩu không chính xác')]

*** Keywords ***
Login To System
    [Arguments]    ${user}    ${pass}
    [Documentation]    Keyword tổng hợp thực hiện các bước đăng nhập
    Wait Until Element Is Visible    ${TXT_USERNAME}    15s
    Input Text        ${TXT_USERNAME}    ${user}
    Input Password    ${TXT_PASSWORD}    ${pass}
    Click Button      ${BTN_SUBMIT}

Verify Login Success
    [Documentation]    Xác nhận đăng nhập thành công vào trang sinh viên
    Wait Until Element Is Visible    ${LBL_SUCCESS_STUDENT}    15s
    Wait Until Page Contains Element    xpath://div[contains(text(),'Trang cá nhân')]    10s
Verify Login Error Message
    [Arguments]    ${expected_msg_locator}
    [Documentation]    Xác nhận thông báo lỗi hiển thị đúng
    Wait Until Element Is Visible    ${expected_msg_locator}    10s
    Element Should Be Visible        ${expected_msg_locator}