*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${MENU_XEM_DIEM}        xpath=//a[@href="/student/marks"]
${SELECT_NAM_HOC}       xpath=//div[@id="mui-component-select-YearStudy"]
${SELECT_HOC_KY}        xpath=//div[@id="mui-component-select-TermID"]

# Locator dùng chung cho các item trong danh sách MUI
${LBL_NO_DATA}    xpath=//td[normalize-space(.)='Không tìm thấy dữ liệu']

# Radio Buttons
${RAD_XEM_DIEM_SV}           xpath=//input[@value='SV']   
${RAD_XEM_DIEM_CTDT}         xpath=//input[@value='CTDT']

# Tables
${TBL_DIEM_SV}               xpath=//table[@aria-label='a dense table']
${TBL_DIEM_CTDT}             xpath=//table[@class='MuiTable-root css-4bzt84']

*** Keywords ***
Navigate To Student Marks Page
    Wait Until Element Is Visible    ${MENU_XEM_DIEM}    20s
    Click Element                    ${MENU_XEM_DIEM}
    Wait Until Location Contains     /student/marks      10s
    Sleep  5s

Select Filter
    [Arguments]    ${target_locator}    ${value}
    Wait Until Element Is Visible    ${target_locator}    15s
    # Click để mở dropdown
    Click Element                    ${target_locator}
    
    # Định vị chính xác li chứa text sau khi đã xóa khoảng trắng thừa
    ${item}=    Set Variable    xpath=//li[@role="option"][normalize-space()="${value}"]
    
    # Chờ menu xổ xuống xuất hiện hẳn
    Wait Until Element Is Visible    ${item}    10s
    Click Element                    ${item}
    
    # Chờ menu đóng lại rồi mới làm việc tiếp theo (Rất quan trọng với MUI)
    Wait Until Element Is Not Visible    ${item}    5s
    Sleep    1s

Verify Filter Result Header
    [Arguments]    ${year}    ${semester}
    ${hk_code}=    Evaluate    {'Học kỳ 1':'HK01','Học kỳ 2':'HK02','Học kỳ 3':'HK03','Tất cả':'HK'}.get('${semester}','HK')
    ${XPATH_HEADER}=    Run Keyword If    '${year}' == 'Tất cả'
    ...    Set Variable    xpath=//strong[contains(., "Học kỳ: ${hk_code}")]
    ...    ELSE    Set Variable    xpath=//strong[contains(., "Năm học: ${year}") and contains(., "Học kỳ: ${hk_code}")]
    Wait Until Element Is Visible    ${XPATH_HEADER}    15s
    Element Should Be Visible        ${XPATH_HEADER}
    Log To Console    > OK: Da thay tieu de bang diem cho ${year} - ${hk_code}.

Verify No Data Displayed
    # Đợi bảng điểm hiện lên trước khi xác nhận thông báo "Không tìm thấy dữ liệu"
    Wait Until Element Is Visible    ${TBL_DIEM_SV}    timeout=20s
    Wait Until Element Is Visible    ${LBL_NO_DATA}    timeout=20s
    Element Should Be Visible        ${LBL_NO_DATA}
    Log To Console    > OK: Thong bao "Không tìm thấy dữ liệu" da duoc hien thi.

Switch To View Student Marks
    Click Element    ${RAD_XEM_DIEM_SV}
    Wait Until Element Is Visible    ${TBL_DIEM_SV}    timeout=15
    
Switch To View Program Marks
    Wait Until Element Is Visible    ${TBL_DIEM_CTDT}    timeout=15
    Click Element    ${RAD_XEM_DIEM_CTDT}
    Wait Until Element Is Visible    ${TBL_DIEM_CTDT}    timeout=15

Open Details By Course Name
    [Arguments]    ${course_name}
    ${xpath_name}      Set Variable    xpath=//td[contains(., '${course_name}')]
    ${xpath_button}    Set Variable    ${xpath_name}/parent::tr//button[@aria-label='expand row']
    
    # Đợi cái Ô CHỨA TÊN hiện ra trước
    Wait Until Element Is Visible    ${xpath_name}    timeout=10s     
    Scroll Element Into View    ${xpath_button}
    Click Element    ${xpath_button}
    Wait Until Page Contains    Chi tiết học phần    timeout=7s

Open Details By Course ID
    [Arguments]    ${course_id}

    ${locator_btn}    Set Variable    xpath=//td[text()='${course_id}']/parent::tr//button[@aria-label='expand row']
    Wait Until Element Is Visible    ${locator_btn}    timeout=10s
    Scroll Element Into View         ${locator_btn}
    Click Element    ${locator_btn}
    Wait Until Page Contains    Chi tiết học phần: ${course_id}    timeout=5s