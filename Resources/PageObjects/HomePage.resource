*** Settings ***
Library     SeleniumLibrary

*** Variables ***
# Sidebar News Categories
${BTN_FEATURED_NEWS}    xpath://span[text()='Thông báo nổi bật']
${BTN_GENERAL_NEWS}     xpath://a[@aria-label='Xem tin Thông báo chung']//div//span
${BTN_REGULATIONS}      xpath://span[text()='Các quy định']
${BTN_TUITION_NEWS}     xpath://span[text()='Thông báo học phí']
# Định vị lại Label tiêu đề ở giữa trang (tránh trùng với Sidebar "Tin tức")
${LBL_NEWS_TITLE}       xpath://div[contains(@class, 'grid-md-9')]//h6//span

# Ô nhập và nút tìm kiếm (đã tối ưu locator)
${TXT_SEARCH_NEWS}      id:searchTinTuc
${BTN_SEARCH_NEWS}      xpath://button[contains(@class, 'MuiButton-containedInfo')]

# Định vị tiêu đề bản tin ĐẦU TIÊN trong danh sách kết quả
# Ta dùng mỏ neo grid-md-9 và tìm thẻ <p> chứa nội dung bản tin
${LBL_FIRST_NEWS_ITEM}  xpath:(//div[contains(@class, 'grid-md-9')]//a//p)[1]

# Thông báo khi không tìm thấy kết quả
${MSG_NO_DATA}          xpath://div[contains(@class, 'grid-md-9')]//*[contains(text(), 'Không có tin tức nào')]

*** Keywords ***
Select News Category And Verify Title
    [Arguments]    ${category_locator}    ${expected_title}
    [Documentation]    Click vào danh mục và kiểm tra tiêu đề giữa trang thay đổi
    Wait Until Element Is Visible    ${category_locator}    15s
    Click Element    ${category_locator}
    
    # Kỹ thuật quan trọng: Chờ cho text của element thay đổi sang giá trị mong muốn
    # Thay vì chỉ chờ Visible, ta chờ đúng cái Text hiện ra để tránh lấy nhầm dữ liệu cũ
    Wait Until Element Contains    ${LBL_NEWS_TITLE}    ${expected_title}    timeout=15s
    Element Text Should Be         ${LBL_NEWS_TITLE}    ${expected_title}

# Keyword mới "đặc trị" cho mục MẶC ĐỊNH (TC_005)
Select Default Category By Toggling State
    [Arguments]    ${category_locator}    ${expected_title}
    
    # 1. Click sang mục khác làm trung gian
    Wait Until Element Is Enabled    ${BTN_FEATURED_NEWS}    15s
    Click Element    ${BTN_FEATURED_NEWS}
    Wait Until Element Contains     ${LBL_NEWS_TITLE}    Thông báo nổi bật    timeout=10s
    
    # 2. QUAN TRỌNG: Đợi mục chính SẴN SÀNG rồi mới CLICK
    Wait Until Element Is Enabled    ${category_locator}    15s
    Click Element    ${category_locator}
    
    # 3. Xác nhận kết quả cuối cùng
    Wait Until Element Contains    ${LBL_NEWS_TITLE}    ${expected_title}    timeout=15s
    Element Text Should Be         ${LBL_NEWS_TITLE}    ${expected_title}

Search News And Verify Result
    [Arguments]    ${keyword}    ${expected_status}=PASS
    [Documentation]    Tìm kiếm và kiểm tra xem kết quả có khớp với từ khóa không
    
    # 1. Nhập liệu
    Wait Until Element Is Visible    ${TXT_SEARCH_NEWS}    15s
    Clear Element Text               ${TXT_SEARCH_NEWS}
    Input Text                       ${TXT_SEARCH_NEWS}    ${keyword}
    
    # 2. Click tìm kiếm và đợi React render lại danh sách
    Click Element                    ${BTN_SEARCH_NEWS}
    Sleep    1.5s    # Đợi một chút để danh sách tin tức cũ biến mất và tin mới hiện ra
    
    # 3. Kiểm tra kết quả tùy theo kịch bản (Thành công hay Không có dữ liệu)
    IF    '${expected_status}' == 'PASS'
        Wait Until Element Is Visible    ${LBL_FIRST_NEWS_ITEM}    15s
        ${actual_text}=    Get Text      ${LBL_FIRST_NEWS_ITEM}
        # Kiểm tra tiêu đề bản tin đầu tiên có chứa từ khóa tìm kiếm không
        Should Contain    ${actual_text.lower()}    ${keyword.lower()}
    ELSE
        Wait Until Element Is Visible    ${MSG_NO_DATA}    15s
        Page Should Contain              Không có tin tức nào
    END