*** Settings ***
Library     SeleniumLibrary
Resource    ../Marketing_Cycle_Detail_Folder/Marketing_Cycle_Detail.resource

*** Variables ***
# Create Marketing Cycle Detail XPath
#${MC_RELATED_TAB}  xpath=(//li[@data-target-selection-name="relatedListsTabTab"]//a[@data-label="Related"])[2]
${MC_RELATED_TAB}  xpath=//records-entity-label[text()='Marketing Cycle']//following::li[@data-target-selection-name="relatedListsTabTab"]//a[@data-label="Related"]
#${MC_RELATED_TAB}  xpath=//li[@data-target-selection-name="relatedListsTabTab"]//a[@data-label="Related"]
${TARGET_KPI_NEW_BUTTON_XPATH}   xpath=//li[@data-target-selection-name='sfdc:StandardButton.Target_KPI__c.New']//button[contains(text(),'New')]
${TARGET_KPI_NEW_PAGE_XPATH}   New Target KPI
${TARGET_KPI_BU_XPATH}  xpath=//div[@data-target-selection-name="sfdc:RecordField.Target_KPI__c.Business_Unit__c"]//input[@placeholder='Search Business Unit...']
${TARGET_KPI_BU_DROWNDOWN_OPTIONS_XPATH}     xpath=//div[@data-target-selection-name="sfdc:RecordField.Target_KPI__c.Business_Unit__c"]//lightning-base-combobox-item[@class='slds-media slds-listbox__option slds-media_center slds-listbox__option_entity' and @role='option']
${TARGET_KPI_BU_OPTION_XPATH}      xpath=(//div[@data-target-selection-name="sfdc:RecordField.Target_KPI__c.Business_Unit__c"]//lightning-base-combobox-item[@class='slds-media slds-listbox__option slds-media_center slds-listbox__option_entity' and @role='option'])[2]
${TARGET_COVERAGE_XPATH}   xpath=//input[@name='Target_Coverage__c']
${TARGET_CALL_RATE_XPATH}   xpath=//input[@name='Target_Call_Rate__c']
${LIMIT_PER_CALL_XPATH}   xpath=//input[@name='Limit_per_Call__c']
${LIMIT_PER_YEAR_XPATH}   xpath=//input[@name='Limit_Per_Year__c']
${TARGET_FREQUENCY_XPATH}   xpath=//input[@name='Target_Frequency__c']
${TARGET_KPI_COUNTRY_DROPDOWN_XPATH}     xpath=//div[@data-target-selection-name="sfdc:RecordField.Target_KPI__c.Country__c"]//button[@aria-label='Country']
${TARGET_KPI_COUNTRY_OPTION_XPATH}     xpath=//div[@data-target-selection-name="sfdc:RecordField.Target_KPI__c.Country__c"]//lightning-base-combobox-item[@role='option' and @data-value='${COUNTRY_NAME}']
${MONTH_DROPDOWN_XPATH}     xpath=//button[@aria-label='Month']
${TARGET_KPI_MONTH_NAME}     October
${MONTH_OPTION_XPATH}     xpath=//lightning-base-combobox-item[@role='option' and @data-value='${TARGET_KPI_MONTH_NAME}']
${YEAR_DROPDOWN_XPATH}     xpath=//button[@aria-label='Year']
${TARGET_KPI_YEAR_NAME}         2025
${YEAR_OPTION_XPATH}     xpath=//lightning-base-combobox-item[@role='option' and @data-value='${TARGET_KPI_YEAR_NAME}']
${SCROLL_CREATED_BY_XPATH}    xpath=//div[@data-target-selection-name='sfdc:RecordField.Target_KPI__c.CreatedById']//span[@class="test-id__field-label"]

${TARGET_KPI_EDIT_ACTION_BUTTON_XPATH}  xpath=(//table[@aria-label="Target KPI"]//button[@class='slds-button slds-button_icon-border slds-button_icon-x-small'])[1]

${TARGET_KPI_DELETE_ACTION_BUTTON_XPATH}    xpath=(//table[@aria-label="Target KPI"]//a[@title='Show 2 more actions'])[1]

*** Keywords ***
Click on Marketing Cycle Related Tab
    Sleep    10s
    Execute Javascript  window.scrollBy(0, -400);
    Wait Until Element Is Visible    ${MC_RELATED_TAB}    10s
    Click Element    ${MC_RELATED_TAB}

Create Target KPI
    Sleep    10s
#     Execute Javascript  window.scrollBy(0, 400);
    FOR    ${index}    IN RANGE    5
        Log To Console   Index is: ${index}
        ${visible}=    Run Keyword And Return Status    Element Should Be Visible   xpath=//span[@title='Target KPI']
        Exit For Loop If    ${visible}
        Execute JavaScript    window.scrollBy(0, 400);
        Sleep    3s
    END
    ${target_kpi_rows}=    Get Element Count    xpath=//table[@aria-label="Target KPI"]//tbody//tr
    Log To Console    Row elements: ${target_kpi_rows}
    ${match_found}    Set Variable    False
    FOR    ${index}    IN RANGE    1    ${target_kpi_rows + 1}
        ${row_text}=    Get Text    //table[@aria-label="Target KPI"]//tbody//tr[${index}]
        Log To Console    Row: ${row_text}
        ${bu_text}=          Get Text    (//table[@aria-label="Target KPI"]//tbody//tr[${index}]/td[3]//span)[2]
        ${month_text}=   Get Text    //table[@aria-label="Target KPI"]//tbody//tr[${index}]/td[4]
        ${year_text}=    Get Text    //table[@aria-label="Target KPI"]//tbody//tr[${index}]/td[5]
        ${is_bu_match}=    Run Keyword And Return Status    Should Be Equal     ${bu_text}      ${BU_NAME}
        ${is_month_match}=    Run Keyword And Return Status    Should Be Equal    ${month_text}    ${TARGET_KPI_MONTH_NAME}
        ${is_year_match}=     Run Keyword And Return Status    Should Be Equal    ${year_text}    ${TARGET_KPI_YEAR_NAME}

        ${match_found}=    Evaluate    ${is_bu_match} and ${is_month_match} and ${is_year_match}
        Exit For Loop If    ${match_found}
    END

    IF    not ${match_found}
            Wait Until Element Is Visible    ${TARGET_KPI_NEW_BUTTON_XPATH}    10s
            Click Element    ${TARGET_KPI_NEW_BUTTON_XPATH}
            Wait Until Page Contains    ${TARGET_KPI_NEW_PAGE_XPATH}    10s
            Input Text    ${TARGET_KPI_BU_XPATH}    ${BU_NAME}
        #    Sleep    5s
            Wait Until Element Is Visible   ${TARGET_KPI_BU_DROWNDOWN_OPTIONS_XPATH}  10s
            Click Element   ${TARGET_KPI_BU_OPTION_XPATH}
            Input Text    ${TARGET_COVERAGE_XPATH}    80
            Input Text    ${TARGET_CALL_RATE_XPATH}    80
            Input Text    ${LIMIT_PER_CALL_XPATH}     4
            Input Text    ${LIMIT_PER_YEAR_XPATH}   200
            Input Text    ${TARGET_FREQUENCY_XPATH}   80
            Scroll Element Into View    ${SCROLL_CREATED_BY_XPATH}
            Click Button    ${MONTH_DROPDOWN_XPATH}
            Click Element   ${MONTH_OPTION_XPATH}
            Wait Until Element Is Visible    ${TARGET_KPI_COUNTRY_DROPDOWN_XPATH}  10s
            Click Button    ${TARGET_KPI_COUNTRY_DROPDOWN_XPATH}
            Click Element   ${TARGET_KPI_COUNTRY_OPTION_XPATH}
            Click Button    ${YEAR_DROPDOWN_XPATH}
            Click Element   ${YEAR_OPTION_XPATH}
            Click Element    ${SAVE_BUTTON_XPATH}

    ELSE
            Log    Matching Target KPI already exists. Skipping creation.
    END







