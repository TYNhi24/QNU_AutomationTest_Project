*** Settings ***
Resource    ../Resources/PageObjects/Common.resource
Resource          ../Resources/PageObjects/Navigate.resource
Resource    ../Resources/PageObjects/LoginPage.resource
Resource    ../Resources/PageObjects/StudentMarksPage.resource

Test Setup       Run Keywords    Mo Trinh Duyet QNU    AND    Navigate To Login Page
Test Teardown    Dong Trinh Duyet QNU

*** Test Cases ***
TC-026: Verify Marks Filter All
    [Documentation]    Kiểm tra bộ lọc ở mặc định, đảm bảo hiển thị tất cả kết quả
    Login To System    4551050152    1521050455
    Navigate To Student Marks Page

    Select Filter    ${SELECT_NAM_HOC}    2022-2023
    Select Filter    ${SELECT_HOC_KY}     -- Tất cả --
    Verify Filter Result Header           2022-2023    Tất cả

TC-027: Verify Marks Filter By Semester
    [Documentation]    Kiểm tra bộ lọc theo năm học và học kỳ, đảm bảo hiển thị đúng kết quả
    Login To System    4551050152    1521050455
    Navigate To Student Marks Page

    Select Filter    ${SELECT_NAM_HOC}    2022-2023
    Select Filter    ${SELECT_HOC_KY}     Học kỳ 1
    Verify Filter Result Header           2022-2023    Học kỳ 1

TC-028: Verify Marks Filter For Semester With is Data
    [Documentation]    Kiểm tra bộ lọc theo năm học và học kỳ cụ thể - có dữ liệu
    Login To System    4551050152    1521050455
    Navigate To Student Marks Page
    
    Select Filter    ${SELECT_NAM_HOC}    2023-2024
    Select Filter    ${SELECT_HOC_KY}     Học kỳ 3
    Verify Filter Result Header           2023-2024    Học kỳ 3

TC-029 : Verify Marks Filter For Semester With No Data
    [Documentation]    Kiểm tra bộ lọc theo năm học và học kỳ cụ thể - không có dữ liệu
    Login To System    4551050152    1521050455
    Navigate To Student Marks Page
    Select Filter    ${SELECT_NAM_HOC}    2024-2025
    Select Filter    ${SELECT_HOC_KY}     Học kỳ 3
    Verify No Data Displayed

TC-030: Verify switching to Program Curriculum display mode
    [Documentation]    Đang ở Xem điểm sinh viên, chuyển sang Xem điểm CTĐT
    Login To System    4551050152    1521050455
    Navigate To Student Marks Page
    Switch To View Program Marks
    Wait Until Element Is Visible    ${TBL_DIEM_CTDT}      10s
    Log To Console    PASS: Đã hiển thị bảng CTĐT.

TC-031: Verify switching back to Student Marks view
    [Documentation]   Đang ở CTĐT, quay lại Xem điểm sinh viên
    Login To System    4551050152    1521050455
    Navigate To Student Marks Page 
    Switch To View Program Marks   
    Switch To View Student Marks
    Wait Until Element Is Visible    ${TBL_DIEM_SV}        10s
    Log To Console    PASS: Đã quay lại bảng Xem điểm SV.

TC-032: Verify opening details of a course by course name
    [Documentation]   Ở bảng Xem điểm sinh viên, mở chi tiết một môn học bằng tên học phần
    Login To System    4551050152    1521050455
    Navigate To Student Marks Page 
    Open Details By Course Name    Kỹ thuật lập trình
    Log To Console    PASS: Đã mở chi tiết môn học thành công.  

TC-033: Verify opening details of a course by course ID
    [Documentation]   Ở bảng Xem điểm sinh viên, mở chi tiết một môn học bằng mã học phần
    Login To System    4551050152    1521050455
    Navigate To Student Marks Page 
    Open Details By Course ID    1050024

TC-034: Verify opening details of a course by course name in Program Curriculum view
    [Documentation]   Kiểm tra bộ lọc ở mặc định 
    Login To System    4551050152    1521050455
    Navigate To Student Marks Page 
    Select Filter    ${SELECT_NAM_HOC}    -- Tất cả --
    Select Filter    ${SELECT_HOC_KY}     -- Tất cả --
    Verify Filter Result Header    Tất cả    Tất cả

TC-035: Verify opening details of a course by course ID in Program Curriculum view
    [Documentation]   Ở bảng Xem điểm CTĐT, mở chi tiết một môn học bằng mã học phần
    Login To System    4551050152    1521050455
    Navigate To Student Marks Page 
    Switch To View Program Marks
    Open Details By Course ID   1010245 
# fail do khong hien mã học phần ở bảng CTĐT, chỉ có tên học phần thôi, vẫn mở chi tiết xem được nhưng thẻ xác nhận bằng mã học phần sẽ không tìm thấy
TC-036: Verify opening details of a course by course name in Program Curriculum view
    [Documentation]   Ở bảng Xem điểm CTĐT, mở chi tiết một môn học bằng tên học phần
    Login To System    4551050152    1521050455
    Navigate To Student Marks Page 
    Switch To View Program Marks
    Open Details By Course Name   Kỹ thuật lập trình 