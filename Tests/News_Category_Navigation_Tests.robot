*** Settings ***
Resource          ../Resources/PageObjects/Common.resource
Resource          ../Resources/PageObjects/HomePage.resource

Test Setup      Mo Trinh Duyet QNU
Test Teardown   Dong Trinh Duyet QNU

*** Test Cases ***
TC_004: Verify Featured News Category
    Select News Category And Verify Title    ${BTN_FEATURED_NEWS}    Thông báo nổi bật

TC_005: Verify General News Category
    Select Default Category By Toggling State    ${BTN_GENERAL_NEWS}     Thông báo chung

TC_006: Verify Regulations Category
    Select News Category And Verify Title    ${BTN_REGULATIONS}      Các quy định

TC_007: Verify Tuition News Category
    Select News Category And Verify Title    ${BTN_TUITION_NEWS}     Thông báo học phí