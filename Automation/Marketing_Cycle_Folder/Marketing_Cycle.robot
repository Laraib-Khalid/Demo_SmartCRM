*** Settings ***
Library     SeleniumLibrary
Resource    Marketing_Cycle.resource

*** Test Cases ***
Create Marketing Cycle
    [Documentation]    Test has only tag 'requirement: 42'.
    [Tags]    smoke
    Search and Create Marketing Cycle