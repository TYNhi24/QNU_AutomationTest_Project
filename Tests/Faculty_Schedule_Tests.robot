*** Settings ***
Resource    ../Resources/PageObjects/Common.resource
Resource    ../Resources/PageObjects/Navigate.resource
Resource    ../Resources/PageObjects/FacultySchedulePage.resource

Test Setup       Run Keywords    Mo Trinh Duyet QNU    AND    Navigate To Faculty Schedule Page
Test Teardown    Dong Trinh Duyet QNU
*** Test Cases ***
# TC-012: Verify Faculty Schedule Search By Accurate Lecturer ID
#     [Documentation]    Kiểm tra tra cứu bằng mã giảng viên chính xác
#     Search Faculty Schedule    2025-2026    Học kỳ 1    Khoa Công nghệ thông tin    002
#     Verify Schedule Found

# TC-013: Verify Faculty Schedule Search With Non-Existent Info
#     [Documentation]    Kiểm tra tra cứu bằng mã giảng viên không tồn tại
#     Search Faculty Schedule    2025-2026    Học kỳ 1    Khoa Công nghệ thông tin    999999
#     Verify No Schedule Found
# TC-014: Verify Faculty Schedule Search By Accurate Lecturer Name
#     [Documentation]    Kiểm tra tra cứu bằng tên giảng viên đầy đủ
#     Search Faculty Schedule    2025-2026    Học kỳ 1    Khoa Công nghệ thông tin    Huỳnh Ngọc Khoa
#     Verify Schedule Found For Lecturer    Huỳnh Ngọc Khoa
# TC-015: Verify Faculty Schedule Search By Lecturer Name Without Tones
#     [Documentation]    Kiểm tra tra cứu bằng tên giảng viên không dấu
#     Search Faculty Schedule    2025-2026    Học kỳ 1    Khoa Công nghệ thông tin    Huynh Ngoc Khoa
#     Verify No Schedule Found

# TC-016: Verify Faculty Schedule Search By Partial Lecturer Name
#     [Documentation]    Kiểm tra tra cứu bằng 1 phần của họ tên giảng viên
#     Search Faculty Schedule    2025-2026    Học kỳ 1    Khoa Công nghệ thông tin    Trần
#     # Quét toàn bộ cột Tên CBGV để xác nhận kết quả
#     Verify All Results Contain Lecturer Name    Trần

# TC-017: Verify Faculty Schedule Search With Empty Lecturer Name
#     [Documentation]    Kiểm tra tra cứu khi để trống ô tìm kiếm (hiển thị danh sách khoa)   
#     # Thực hiện tra cứu với 3 filter đầu, để trống ô Mã GV/Họ tên
#     Search Faculty Schedule    2024-2025    Học kỳ 2    Khoa Công nghệ thông tin    ${EMPTY}
#     # Xác nhận bảng hiển thị danh sách kết quả chung
#     Verify Schedule List Found

# TC-018: Verify Faculty Schedule select Oldest Academic Year
#     [Documentation]    Kiểm tra Chọn Năm học cũ nhất
#     Search Faculty Schedule    2010-2011    Học kỳ 1    Khoa Công nghệ thông tin    ${EMPTY}
#     Verify No Schedule Found

# TC-019: Verify Faculty Schedule select Summer Semester
#     [Documentation]    Kiểm tra Chọn Học kỳ hè
#     Search Faculty Schedule By Pressing Enter   2016-2017   Học kỳ 3   Khoa Công nghệ thông tin    Trần
#     Verify All Results Contain Lecturer Name    Trần

TC-020: Verify Faculty Schedule Refresh Button
    [Documentation]    Kiểm tra nút "Làm mới"
    Search Faculty Schedule    2016-2017    Học kỳ 2    Khoa Ngoại ngữ    Đào
    Verify Schedule Found
    Verify Refresh Button Clears Filters   