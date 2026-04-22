*** Settings ***
Resource    ../Resources/PageObjects/Common.resource
Resource          ../Resources/PageObjects/Navigate.resource
Resource    ../Resources/PageObjects/LoginPage.resource
Resource    ../Resources/PageObjects/StudentMarksPage.resource

Test Setup       Run Keywords    Mo Trinh Duyet QNU    AND    Navigate To Login Page
Test Teardown    Dong Trinh Duyet QNU

*** Test Cases ***
# TC-005: Verify Marks Filter By Semester
#     [Tags]             Functional
#     Login To System    4551050152    1521050455
#     Navigate To Student Marks Page

#     Select Filter    ${SELECT_NAM_HOC}    2022-2023
#     Select Filter    ${SELECT_HOC_KY}     Học kỳ 1
#     Verify Filter Result Header           2022-2023    Học kỳ 1

# TC-006: Verify Marks Filter All
#     [Tags]             Functional
#     Login To System    4551050152    1521050455
#     Navigate To Student Marks Page

#     Select Filter    ${SELECT_NAM_HOC}    2022-2023
#     Select Filter    ${SELECT_HOC_KY}     -- Tất cả --
#     Verify Filter Result Header           2022-2023    Tất cả

# TC-007: Verify Marks Filter For Semester With is Data
#     [Tags]             Functional
#     Login To System    4551050152    1521050455
#     Navigate To Student Marks Page
    
#     Select Filter    ${SELECT_NAM_HOC}    2023-2024
#     Select Filter    ${SELECT_HOC_KY}     Học kỳ 3
#     Verify Filter Result Header           2023-2024    Học kỳ 3
# case này lỗi không thấy đc phần tử
TC-008 : Verify Marks Filter For Semester With No Data
    [Tags]             Functional
    Login To System    4551050152    1521050455
    Navigate To Student Marks Page
    
    Select Filter    ${SELECT_NAM_HOC}    2024-2025
    Select Filter    ${SELECT_HOC_KY}     Học kỳ 3
    Verify No Data Displayed


# TC-010: Verify switching to Program Curriculum display mode
#     [Documentation]    Đang ở Xem điểm sinh viên, chuyển sang Xem điểm CTĐT.
#     [Tags]            Functional
#     Login To System    4551050152    1521050455
#     Navigate To Student Marks Page
#     Switch To View Program Marks
#     Wait Until Element Is Visible    ${TBL_DIEM_CTDT}      10s
#     Log To Console    PASS: Đã hiển thị bảng CTĐT.

# TC-011: Verify switching back to Student Marks view
#     [Documentation]   Đang ở CTĐT, quay lại Xem điểm sinh viên.
#     [Tags]            Functional
#     Login To System    4551050152    1521050455
#     Navigate To Student Marks Page 
#     Switch To View Program Marks   
#     Switch To View Student Marks
#     Wait Until Element Is Visible    ${TBL_DIEM_SV}        10s
#     Log To Console    PASS: Đã quay lại bảng Xem điểm SV.