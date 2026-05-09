*** Settings ***
Resource          ../Resources/PageObjects/Common.resource
Resource          ../Resources/PageObjects/HomePage.resource

Test Setup      Mo Trinh Duyet QNU
Test Teardown   Dong Trinh Duyet QNU

*** Test Cases ***
TC_008: Search With Exact Keyword
    [Documentation]    Tìm kiếm từ khóa chính xác
    Search News And Verify Result      Hướng dẫn đăng ký học phần    PASS
    # Kiểm tra xem tiêu đề vùng tin tức có chứa từ khóa vừa tìm không
    Page Should Contain  Hướng dẫn đăng ký học phần

TC_009: Search With Partial Keyword
    [Documentation]    Tìm kiếm một phần từ khóa
    Search News And Verify Result    học phần    PASS
    Page Should Contain         học phần

TC_010: Search With Non-Existent Keyword
    [Documentation]    Tìm kiếm không có kết quả
    Search News And Verify Result    asdfgh123    FAIL

TC_011: Search With No-Tone Vietnamese
    [Documentation]    Tìm kiếm tiếng Việt không dấu
    Search News And Verify Result    hoc phan    FAIL
    Wait Until Element Is Visible    ${MSG_NO_DATA}    10s

TC_012: Search With Capital Letters
    [Documentation]    Tìm kiếm với ký tự viết hoa
    Search News And Verify Result    HỌC PHẦN    PASS
    Page Should Contain         học phần

TC_013: Search With Leading And Trailing Spaces
    [Documentation]    Tìm kiếm với khoảng trắng ở đầu và cuối
    ${keyword}=    Set Variable      ${SPACE}${SPACE}học phần${SPACE}${SPACE}
    Search News And Verify Result    ${keyword}    PASS
    Page Should Contain         học phần
  
TC_014: Search With Special Icon
    [Documentation]    Tìm kiếm với icon đặc biệt
    Search News And Verify Result    ★※✓    FAIL
    Wait Until Element Is Visible    ${MSG_NO_DATA}    10s

