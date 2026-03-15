*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Dropdown inputs
${INPUT_YEAR}           xpath://label[text()='Năm học']/following-sibling::div//input
${INPUT_SEMESTER}       xpath://label[text()='Học kỳ']/following-sibling::div//input
${INPUT_FACULTY}        xpath://label[text()='Khoa']/following-sibling::div//input
${INPUT_LECTURER_ID}    xpath://label[contains(text(),'Mã GV')]/following-sibling::div//input
${BTN_FILTER}           xpath://button[contains(@class, 'MuiButton-containedPrimary') and contains(., 'Lọc')]
${BTN_REFRESH}          xpath://button[contains(text(),'Làm mới')]
# Định vị vùng kết quả
${TABLE_SCHEDULE}       xpath://table[contains(@class, 'schedule-table')]
${CELL_NO_SCHEDULE}     xpath://td[contains(text(), 'Chưa có lịch học')]
${LBL_RESULT_HEADER}    xpath://div[contains(@class, 'schedule-header-section')]

*** Keywords ***
Select Mui Dropdown Item
    [Arguments]    ${input_locator}    ${value}
    Wait Until Element Is Visible    ${input_locator}    15s
    Click Element    ${input_locator}
    Wait Until Element Is Visible    xpath://li[contains(text(),'${value}')]    10s
    Click Element                    xpath://li[contains(text(),'${value}')]

Search Faculty Schedule
    [Arguments]    ${year}    ${semester}    ${faculty}    ${lecturer_id}
    Select Mui Dropdown Item    ${INPUT_YEAR}        ${year}
    Select Mui Dropdown Item    ${INPUT_SEMESTER}    ${semester}
    Select Mui Dropdown Item    ${INPUT_FACULTY}     ${faculty}
    Input Text      ${INPUT_LECTURER_ID}    ${lecturer_id}
    Click Element    ${BTN_FILTER}
    # Chờ vùng bảng kết quả xuất hiện hoặc cập nhật
    Wait Until Element Is Visible    ${TABLE_SCHEDULE}    15s

Search Faculty Schedule By Pressing Enter
    [Arguments]    ${year}    ${semester}    ${faculty}    ${lecturer_id}
    Select Mui Dropdown Item    ${INPUT_YEAR}        ${year}
    Select Mui Dropdown Item    ${INPUT_SEMESTER}    ${semester}
    Select Mui Dropdown Item    ${INPUT_FACULTY}     ${faculty}
    Input Text      ${INPUT_LECTURER_ID}    ${lecturer_id}
    # Nhấn ENTER ngay tại ô nhập liệu thay vì click nút Lọc
    Press Keys      ${INPUT_LECTURER_ID}    ENTER
    Wait Until Element Is Visible    ${TABLE_SCHEDULE}    15s

Verify Schedule Found
    [Documentation]    Xác nhận bảng hiển thị dữ liệu lịch dạy
    Wait Until Element Is Visible    ${TABLE_SCHEDULE}    15s
    # Đảm bảo KHÔNG xuất hiện dòng "Chưa có lịch học"
    Page Should Not Contain Element    ${CELL_NO_SCHEDULE}
    # Kiểm tra xem có ít nhất một dòng dữ liệu trong thân bảng
    Element Should Be Visible          xpath://tbody/tr[1]

Verify No Schedule Found
    [Documentation]    Xác nhận hiển thị thông báo "Chưa có lịch học"
    Wait Until Element Is Visible    ${CELL_NO_SCHEDULE}    15s
    Element Text Should Be           ${CELL_NO_SCHEDULE}    Chưa có lịch học

Verify Schedule Found For Lecturer
    [Arguments]    ${expected_name}
    [Documentation]    Xác nhận bảng hiển thị lịch dạy của đúng giảng viên
    Wait Until Element Is Visible    ${TABLE_SCHEDULE}    15s
    # Kiểm tra xem dòng đầu tiên trong bảng có chứa tên giảng viên không, Cột 8 là cột Tên GV 
    Element Should Contain    xpath://tbody/tr[1]/td[8]    ${expected_name}   
    # Đảm bảo không có dòng "Chưa có lịch học"
    Page Should Not Contain Element    ${CELL_NO_SCHEDULE}

Verify All Results Contain Lecturer Name
    [Arguments]    ${search_keyword}
    [Documentation]    Quét toàn bộ danh sách kết quả để kiểm tra cột Tên CBGV

    # 1. Đếm tổng số dòng dữ liệu hiện có
    ${row_count}=    Get Element Count    xpath://table[contains(@class, 'schedule-table')]/tbody/tr
    
    # 2. Quét nhanh từng dòng để kiểm tra cột Tên CBGV (cột 8)
    FOR    ${index}    IN RANGE    1    ${row_count} + 1
        ${cell_text}=    Get Text    xpath://table[contains(@class, 'schedule-table')]/tbody/tr[${index}]/td[8]
        # Kiểm tra khớp chính xác từ khóa 
         Should Contain    ${cell_text}    ${search_keyword}    msg=Dòng ${index} không khớp từ khóa
        # Bắt Robot chạy tiếp kể cả khi dòng này bị sai
        # Run Keyword And Continue On Failure    Should Contain    ${cell_text}    ${search_keyword}    msg=Dòng ${index} không khớp từ khóa
    END
    
    # 3. Log kết quả kèm số lượng dòng thực tế
    Log    Hoàn thành quét ${row_count} dòng. Tất cả đều khớp chính xác!

Verify Schedule List Found
    [Documentation]    Xác nhận bảng hiển thị danh sách thời khóa biểu chung của khoa
    Wait Until Element Is Visible    ${TABLE_SCHEDULE}    15s
    
    # 1. Đảm bảo KHÔNG xuất hiện dòng "Chưa có lịch học"
    Page Should Not Contain Element    ${CELL_NO_SCHEDULE}
    
    # 2. Kiểm tra xem có dữ liệu ở dòng đầu tiên
    Element Should Be Visible          xpath://tbody/tr[1]
    
    # 3. Kiểm tra xem cột Tên CBGV (cột 8) có dữ liệu hay không
    ${lecturer_name}=    Get Text      xpath://tbody/tr[1]/td[8]
    Should Not Be Empty    ${lecturer_name}

Verify Refresh Button Clears Filters
    [Documentation]    Kiểm tra các bộ lọc và bảng kết quả sau khi nhấn Làm mới
    # 1. Nhấn nút Làm mới
    Click Element    ${BTN_REFRESH}
    Sleep    3s
    
    # 2. Xác nhận Khoa quay về mặc định
    # Với MUI Autocomplete, ta kiểm tra thuộc tính 'value' của thẻ input
    ${faculty_val}=    Get Element Attribute    ${INPUT_FACULTY}    value
    Should Be Equal As Strings    ${faculty_val}    Trường đại học Quy Nhơn
    
    # 3. Xác nhận ô Mã GV / Họ tên được xóa trống
    ${lecturer_val}=    Get Element Attribute    ${INPUT_LECTURER_ID}    value
    Should Be Empty     ${lecturer_val}
    
    # 4. Xác nhận bảng quay về trạng thái "Chưa có lịch học"
    Verify No Schedule Found