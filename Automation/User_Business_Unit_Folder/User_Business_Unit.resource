*** Settings ***
Library     SeleniumLibrary
Resource    ../Business_Unit_Folder/Business_Unit.resource
Resource    ../TCL_Folder/TCL.resource

*** Variables ***
# Create Business Unit XPath
${USER_BU_NEW_BUTTON_XPATH}  xpath=//li[@data-target-selection-name='sfdc:StandardButton.User_Business_Unit__c.New']//button[contains(.,'New')]
${SEARCH_USER_DROPDOWN_OPTIONS_XPATH}   xpath=//lightning-base-combobox-item[@class='slds-media slds-listbox__option slds-media_center slds-listbox__option_entity' and @role='option']
${SEARCH_USER_OPTION_XPATH}     xpath=(//lightning-base-combobox-item[@class='slds-media slds-listbox__option slds-media_center slds-listbox__option_entity' and @role='option'])[2]
${USER_BU_ACTIVE_CHECKBOX_XPATH}    xpath=//input[@name='Active__c']
#${USER_BU_XPATH_OPTION}    xpath=//lightning-base-combobox-formatted-text[@title='US Test Business Unit']
${USER_BU_START_DATE_OPTION}    Mar 1, 2025
${USER_BU_END_DATE_OPTION}    June 30, 2025
${SEARCH_BUSINESS_UNIT_DROWNDOWN_XPATH}  xpath=(//input[contains(@id,'combobox-input-')])[2]
${SEARCH_BUSINESS_UNIT_DROWNDOWN_OPTIONS_XPATH}     xpath=//lightning-base-combobox-item[@class='slds-media slds-listbox__option slds-media_center slds-listbox__option_entity' and @role='option']
${SEARCH_BUSINESS_UNIT_OPTION_XPATH}      xpath=(//lightning-base-combobox-item[@class='slds-media slds-listbox__option slds-media_center slds-listbox__option_entity' and @role='option'])[2]
#${SEARCH_BUSINESS_UNIT_OPTION_XPATH}      xpath=//lightning-base-combobox-formatted-text[contains(@title,"${BU_NAME}")]
${CREATE_BUTTON_XPATH}    xpath=//button[contains(.,'Create')]
${USER_BU_EDIT_ACTION_BUTTON_XPATH}  xpath=//button[@class='slds-button slds-button_icon-border slds-button_icon-x-small']
${EDIT_ACTION_USER_BU_XPATH}    xpath=//a[@title='Edit']
${EDIT_USER_BU_ACTIVE_CHECKBOX_XPATH}    xpath=(//span[@class='slds-checkbox slds-checkbox_standalone']//input[@name='Active__c'])[2]
${USER_BU_END_DATE_XPATH}     xpath=(//input[@name='End_Date__c'])[2]
${USER_BU_DELETE_ACTION_BUTTON_XPATH}  xpath=//a[@title='Show 2 more actions']
${DELETE_ACTION_USER_BU_XPATH}    xpath=//a[@title='Delete']

*** Keywords ***
Create User Business Unit
    Sleep    10s
#    Search and Create Business Unit
#    Execute JavaScript    window.scrollBy(0, 400);
#    Execute JavaScript    document.evaluate("//li[@data-target-selection-name='sfdc:StandardButton.User_Business_Unit__c.New']//button[text()='New']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView({ behavior: 'smooth', block: 'center' });
    FOR    ${index}    IN RANGE    5
        Log To Console   Index is: ${index}
         ${visible}=    Run Keyword And Return Status    Element Should Be Visible   ${USER_BU_NEW_BUTTON_XPATH}
        Exit For Loop If    ${visible}
        Execute JavaScript    window.scrollBy(0, 400);
    END
    Sleep    5s
    
#    Checkbox Should Be Selected    //input[@type='checkbox' and @name='Active__c']
    ${user_bu_rows}=    Get Element Count    xpath=//table[@aria-label="User Business Unit"]//tbody//tr
    Log To Console    Row elements: ${user_bu_rows}
    FOR    ${index}    IN RANGE    1    ${user_bu_rows + 1}
        ${row_text}=    Get Text    //table[@aria-label="User Business Unit"]//tbody//tr[${index}]
        Log To Console    Row: ${row_text}
        ${user_text}=          Get Text    (//table[@aria-label="User Business Unit"]//tbody//tr[${index}]/td[3]//span)[2]
        ${is_checked}=    Run Keyword And Return Status    Checkbox Should Be Selected    xpath=//table[@aria-label="User Business Unit"]//tbody//tr[${index}]/td[4]//input[@type='checkbox' and @name='Active__c']

        ${country_text}=    Get Text    //table[@aria-label="User Business Unit"]//tbody//tr[${index}]/td[5]
        ${is_user_match}=    Run Keyword And Return Status    Should Be Equal     ${user_text}      ${SEARCH_USER_TEXT}
        ${is_country_match}=     Run Keyword And Return Status    Should Be Equal    ${country_text}    ${COUNTRY_NAME}
        ${match_found}=    Evaluate    ${is_user_match} and ${is_checked} and ${is_country_match}
            Exit For Loop If    ${match_found}
        END

        IF    not ${match_found}
            Wait Until Element Is Visible    ${USER_BU_NEW_BUTTON_XPATH}    10s
            Click Element    ${USER_BU_NEW_BUTTON_XPATH}
            Sleep    5s
            Input Text     ${SEARCH_USER_DROPDOWN_XPATH}   ${SEARCH_USER_TEXT}
            Wait Until Element Is Visible    ${SEARCH_USER_DROPDOWN_OPTIONS_XPATH}  10s
            Click Element    ${SEARCH_USER_OPTION_XPATH}
            Click Button    ${COUNTRY_DROPDOWN_XPATH}
            Click Element   ${COUNTRY_OPTION_XPATH}
            Select Checkbox    ${USER_BU_ACTIVE_CHECKBOX_XPATH}
            Input Text      ${SEARCH_BUSINESS_UNIT_DROWNDOWN_XPATH}   ${BU_NAME}
            ${USER_BU_XPATH_OPTION}  Set Variable    xpath=//lightning-base-combobox-formatted-text[@title='${BU_NAME}']
            Wait Until Element Is Visible  ${USER_BU_XPATH_OPTION}    10s
            Click Element   ${USER_BU_XPATH_OPTION}
            Input Text    ${START_DATE_XPATH}    ${USER_BU_START_DATE_OPTION}
        #    Input Text    ${END_DATE_XPATH}      ${USER_BU_END_DATE_OPTION}
            Click Button    ${CREATE_BUTTON_XPATH}
        ELSE
            Log    User Business Unit already exists. Skipping creation.
        END