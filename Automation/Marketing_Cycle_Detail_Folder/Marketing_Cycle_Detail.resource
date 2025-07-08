*** Settings ***
Library     SeleniumLibrary
Resource    ../Marketing_Cycle_Folder/Marketing_Cycle.resource
Resource    ../Contact_Business_Unit_Folder/Contact_Business_Unit.resource
Library     ../Marketing_Cycle_Detail_Folder/scroll_keyword.py


*** Variables ***
# Create Marketing Cycle Detail XPath
${MC_DETAIL_NEW_BUTTON_XPATH}   xpath=//li[@data-target-selection-name='sfdc:StandardButton.MarketingCycleDetail__c.New']//button[contains(text(),'New')]
${NEW_MC_DETAIL_PAGE}  New Marketing Cycle Detail
${SEARCH_MC_DETAIL_BUSINESS_UNIT_DROWNDOWN_XPATH}   xpath=//div[@data-target-selection-name='sfdc:RecordField.MarketingCycleDetail__c.Business_Unit__c']//input[contains(@placeholder,'Business Unit')]
${SEARCH_MC_DETAIL_BUSINESS_UNIT_DROWNDOWN_OPTIONS_XPATH}     xpath=//div[@data-target-selection-name="sfdc:RecordField.MarketingCycleDetail__c.Business_Unit__c"]//lightning-base-combobox-item[@class='slds-media slds-listbox__option slds-media_center slds-listbox__option_entity' and @role='option']
${SEARCH_MC_DETAIL_BUSINESS_UNIT_OPTION_XPATH}      xpath=(//div[@data-target-selection-name="sfdc:RecordField.MarketingCycleDetail__c.Business_Unit__c"]//lightning-base-combobox-item[@class='slds-media slds-listbox__option slds-media_center slds-listbox__option_entity' and @role='option'])[2]
${MC_DETAIL_COUNTRY_DROPDOWN_XPATH}     xpath=//div[@data-target-selection-name='sfdc:RecordField.MarketingCycleDetail__c.Country__c']//button[@aria-label='Country']
${MC_DETAIL_COUNTRY_OPTION_XPATH}     xpath=//div[@data-target-selection-name='sfdc:RecordField.MarketingCycleDetail__c.Country__c']//lightning-base-combobox-item[@role='option' and @data-value='United Arab Emirates']

${MC_DETAIL_SPECIALTY_NAME}     ENT
${MC_DETAIL_FREQUENCY_DROPDOWN_XPATH}  xpath=//button[@aria-label='Frequency']
${MC_DETAIL_FREQUENCY_OPTION_XPATH}     xpath=//lightning-base-combobox-item[@data-value='2']
${MC_DETAIL_SPECIALTY_OPTION_XPATH}     xpath=//div[@data-value='${MC_DETAIL_SPECIALTY_NAME}']
${MC_DETAIL_MOVE_TO_BUTTON_XPATH}     xpath=//button[@title='Move to Chosen']//lightning-primitive-icon[@variant='bare']

*** Keywords ***
Search and Create Marketing Cycle Detail
    Sleep    5s
    # Wait until the table is present
    Wait Until Page Contains Element    xpath=//table[@aria-label="Marketing Cycle Detail"]    20s

#    # Extract the entire table text
#    ${table_text}=    Get Text    xpath=//table[@aria-label="Marketing Cycle Detail"]//tbody
#    ${entry_found}=    Run Keyword And Return Status    Should Match Regexp    ${table_text}    (?i).*${BU_NAME}.*${MC_DETAIL_SPECIALTY_NAME}.*${CONTACT_BU_PRIORITY_NAME}.*
#
#    IF    ${entry_found}
#        Log    Entry with same Business Unit, Specialty and Priority already exists. Skipping creation.    WARN
#        RETURN
#    END

    Execute JavaScript    document.evaluate("//li[@data-target-selection-name='sfdc:StandardButton.MarketingCycleDetail__c.New']//button[text()='New']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView({ behavior: 'smooth', block: 'center' });
    Sleep    3s
#
#    ${rows}=    Get WebElements    xpath=//table[@aria-label="Marketing Cycle Detail"]//tbody/tr
#    ${entry_found}=    Set Variable    False
#
#    FOR    ${row}    IN    @{rows}
#        ${cells}=    Get WebElements    xpath=.//td    parent=${row}



    Wait Until Page Contains Element    xpath=//table[@aria-label="Marketing Cycle Detail"]    20s
#    ${table_rows}       Set Variable        xpath=//table[@aria-label="Marketing Cycle Detail"]//tbody//tr
#    ${rows}=    Get WebElements    xpath=//table[@aria-label="Marketing Cycle Detail"]//tbody//tr
#    FOR    ${r}    IN    ${rows}
#        ${row_text}=    Get Text    ${r}
#        Log To Console    Row: ${row_text}
#        ${cells}=    Get WebElements    xpath=${r}//td
#
#        ${bu_text}=            Get Text    ${cells}[3]     # Index starts from 0, so [2] is 3rd column
#        ${specialty_text}=     Get Text    ${cells}[4]     # 4th column
#        ${priority_text}=      Get Text    ${cells}[5]     # 5th column

#        ${bu_text}=            Get Text    xpath=//table[@aria-label="Marketing Cycle Detail"]//tbody//tr//td[3]
#        ${specialty_text}=     Get Text    xpath=//table[@aria-label="Marketing Cycle Detail"]//tbody//tr//td[4]
#        ${priority_text}=      Get Text    xpath=//table[@aria-label="Marketing Cycle Detail"]//tbody//tr//td[5]
#        Log To Console     ${bu_text} ${specialty_text} ${priority_text}
#    END

#    ${rows}=    Get Element Count    xpath=//table[@aria-label="Marketing Cycle Detail"]//tbody//tr
#    Log To Console    ${rows}
#    FOR    ${index}    IN RANGE    1    ${rows + 1}
#        ${bu_xpath}=    Set Variable    //table[@aria-label="Marketing Cycle Detail"]//tbody//tr[${index}]/td[3]
#        ${specialty_xpath}=    Set Variable    //table[@aria-label="Marketing Cycle Detail"]//tbody//tr[${index}]/td[4]
#        ${priority_xpath}=     Set Variable    //table[@aria-label="Marketing Cycle Detail"]//tbody//tr[${index}]/td[5]
#
#        ${bu_text}=            Get Text    xpath=${bu_xpath}
#        ${specialty_text}=     Get Text    xpath=${specialty_xpath}
#        ${priority_text}=      Get Text    xpath=${priority_xpath}
#
#        Log To Console    Row ${index}: BU: ${bu_text}, Specialty: ${specialty_text}, Priority: ${priority_text}
#    END
#    ${match_found}=    Set Variable    False
#    ${rows}=    Get Element Count    xpath=//table[@aria-label="Marketing Cycle Detail"]//tbody//tr
#
#    ${expected_bu}=        Evaluate    '${BU_NAME}'
#    ${expected_specialty}=   Evaluate    '${MC_DETAIL_SPECIALTY_NAME}'
#    ${expected_priority}=  Evaluate    '${CONTACT_BU_PRIORITY_NAME}'
#
#    FOR    ${index}    IN RANGE    1    ${rows + 1}
#        ${bu_xpath}=          Set Variable    //table[@aria-label="Marketing Cycle Detail"]//tbody//tr[${index}]/td[3]
#        ${specialty_xpath}=   Set Variable    //table[@aria-label="Marketing Cycle Detail"]//tbody//tr[${index}]/td[4]
#        ${priority_xpath}=    Set Variable    //table[@aria-label="Marketing Cycle Detail"]//tbody//tr[${index}]/td[5]
#
#        ${bu_text}=           Get Text    xpath=${bu_xpath}
#        ${specialty_text}=    Get Text    xpath=${specialty_xpath}
#        ${priority_text}=     Get Text    xpath=${priority_xpath}
#
#        ${match_found}=    Run Keyword And Return Status
##        ...    Should Be Equal    ${bu_text}         ${expected_bu}
#        ...    Should Be Equal    ${specialty_text}    ${expected_specialty}
#        ...    AND    Should Be Equal    ${priority_text}     ${expected_priority}
#
#        Run Keyword If    ${match_found}    Log To Console    Data already exists. Skipping creation.
#        Run Keyword If    ${match_found}    Exit For Loop
#    END
#
#    Run Keyword Unless    ${match_found}    Create New Marketing Cycle Detail
    ${rows}=    Get Element Count    xpath=//table[@aria-label="Marketing Cycle Detail"]//tbody//tr
#    ${rows}=    Get WebElements    xpath=//table[@aria-label="Marketing Cycle Detail"]//tbody//tr
#    ${row_elements}=    Get WebElements    xpath=//table[@aria-label="Marketing Cycle Detail"]//tbody//tr
    Log To Console    Row elements: ${rows}

    ${expected_bu}=         Set Variable    ${BU_NAME}
    ${expected_specialty}=  Set Variable    ${MC_DETAIL_SPECIALTY_NAME}
    ${expected_priority}=   Set Variable    ${CONTACT_BU_PRIORITY_NAME}
#    ${match_found}=         Set Variable    False

    FOR    ${index}    IN RANGE    1    ${rows + 1}
        Log To Console    Rows + 1 : ${rows + 1}
        ${row_text}=    Get Text    //table[@aria-label="Marketing Cycle Detail"]//tbody//tr[${index}]
        Log To Console    Row: ${row_text}
        ${bu_xpath}=          Set Variable    (//table[@aria-label="Marketing Cycle Detail"]//tbody//tr[1]/td[3]//span)[2]
        ${specialty_xpath}=   Set Variable    //table[@aria-label="Marketing Cycle Detail"]//tbody//tr[${index}]/td[4]
        ${priority_xpath}=    Set Variable    //table[@aria-label="Marketing Cycle Detail"]//tbody//tr[${index}]/td[5]
        ${bu_text}=           Get Text    xpath=${bu_xpath}
        ${specialty_text}=    Get Text    xpath=${specialty_xpath}
        ${priority_text}=     Get Text    xpath=${priority_xpath}
        ${is_bu_match}=    Run Keyword And Return Status    Should Be Equal     ${bu_text}      ${expected_bu}
        ${is_specialty_match}=    Run Keyword And Return Status    Should Be Equal    ${specialty_text}    ${expected_specialty}
        ${is_priority_match}=     Run Keyword And Return Status    Should Be Equal    ${priority_text}    ${expected_priority}

        ${match_found}=    Evaluate   ${is_bu_match} and ${is_specialty_match} and ${is_priority_match}
            Exit For Loop If    ${match_found}
    END

    IF    not ${match_found}
            Create New Marketing Cycle Detail
    ELSE
            Log    Matching Marketing Cycle Detail already exists. Skipping creation.
    END

Create New Marketing Cycle Detail
    Click Element    ${MC_DETAIL_NEW_BUTTON_XPATH}
    Sleep    8s

    Set Focus To Element    ${SEARCH_MC_DETAIL_BUSINESS_UNIT_DROWNDOWN_XPATH}
    Input Text      ${SEARCH_MC_DETAIL_BUSINESS_UNIT_DROWNDOWN_XPATH}   ${BU_NAME}
    Sleep    3s
    Wait Until Element Is Visible   ${SEARCH_MC_DETAIL_BUSINESS_UNIT_DROWNDOWN_OPTIONS_XPATH}   10s
    Click Element   ${SEARCH_MC_DETAIL_BUSINESS_UNIT_OPTION_XPATH}

    Click Button    ${MC_DETAIL_FREQUENCY_DROPDOWN_XPATH}
    Click Element   ${MC_DETAIL_FREQUENCY_OPTION_XPATH}

    Click Button    ${MC_DETAIL_COUNTRY_DROPDOWN_XPATH}
    Click Element   ${MC_DETAIL_COUNTRY_OPTION_XPATH}

    Click Button    ${CONTACT_PRIORITY_DROPDOWN_XPATH}
    Click Element   ${CONTACT_BU_PRIORITY_OPTION_XPATH}

    Sleep    3s
    Execute JavaScript    document.evaluate("//div[contains(text(),'Specialty')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView()
    Sleep    3s
    Set Focus To Element    ${MC_DETAIL_SPECIALTY_OPTION_XPATH}
    Set Focus To Element    ${MC_DETAIL_MOVE_TO_BUTTON_XPATH}
    Click Element    ${MC_DETAIL_MOVE_TO_BUTTON_XPATH}

    Click Element    ${SAVE_BUTTON_XPATH}

#    ${rows}=    Get WebElements    xpath=//table[@aria-label="Marketing Cycle Detail"]//tbody//tr
#
#    FOR    ${row}    IN    @{rows}
#        # Get cell 3 (Business Unit)
#        ${cell3}=    Execute JavaScript    return arguments[0].querySelectorAll('td')[2];    ${row}
#        ${bu_text}=    Get Text    ${cell3}
#
#        # Get cell 4 (Specialty)
#        ${cell4}=    Execute JavaScript    return arguments[0].querySelectorAll('td')[3];    ${row}
#        ${specialty_text}=    Get Text    ${cell4}
#
#        # Get cell 5 (Priority)
#        ${cell5}=    Execute JavaScript    return arguments[0].querySelectorAll('td')[4];    ${row}
#        ${priority_text}=    Get Text    ${cell5}
#
#        Log To Console    BU: ${bu_text}, Specialty: ${specialty_text}, Priority: ${priority_text}
#    END


#    ${rows}=    Get WebElements    xpath=//table[@aria-label="Marketing Cycle Detail"]//tbody//tr
#    FOR    ${r}    IN    @{rows}
#        ${row_text}=    Get Text    ${r}
#        Log To Console    Row: ${row_text}
#
#        # Corrected line: Use the parent WebElement directly in the XPath
##        ${cells}=    ${r}.Find Elements    xpath=./td
##        ${cells}=    Get WebElements    ${r}    xpath=./td
#        ${cells}=    Execute JavaScript    return arguments[0].querySelectorAll('td');    ${r}
#        ${bu_text}=          Get Text    ${cells}[2]      # 3rd column
#        ${specialty_text}=    Get Text    ${cells}[3]      # 4th column
#        ${priority_text}=     Get Text    ${cells}[4]      # 5th column
#
#        Log To Console    BU: ${bu_text}, Specialty: ${specialty_text}, Priority: ${priority_text}
#    END

#    ${rows}=    Get WebElements    xpath=//table[@aria-label="Marketing Cycle Detail"]//tbody//tr
#    Log To Console    ${rows}
#    ${entry_found}=    Set Variable    False
#
#    FOR    ${row}    IN    @{rows}
#        ${bu_text}=            Get Text    xpath=//table[@aria-label="Marketing Cycle Detail"]//tbody//tr//td[3]
#        ${specialty_text}=     Get Text    xpath=//table[@aria-label="Marketing Cycle Detail"]//tbody//tr//td[4]
#        ${priority_text}=      Get Text    xpath=//table[@aria-label="Marketing Cycle Detail"]//tbody//tr//td[5]
#        Log To Console     ${bu_text} ${specialty_text} ${priority_text}
##
##        ${bu_text}=            Get Text    ${cells[3]}
##        ${specialty_text}=     Get Text    ${cells[4]}
##        ${priority_text}=      Get Text    ${cells[5]}
#
#        ${bu_text}=            Evaluate    '${bu_text}'.strip().lower()
#        ${specialty_text}=     Evaluate    '${specialty_text}'.strip().lower()
#        ${priority_text}=      Evaluate    '${priority_text}'.strip().lower()
#
#        ${expected_bu}=        Evaluate    '${BU_NAME}'.strip().lower()
#        ${expected_specialty}=  Evaluate    '${MC_DETAIL_SPECIALTY_NAME}'.strip().lower()
#        ${expected_priority}=  Evaluate    '${CONTACT_BU_PRIORITY_NAME}'.strip().lower()
#
#        Run Keyword If    '${bu_text}' == '${expected_bu}' and '${specialty_text}' == '${expected_specialty}' and '${priority_text}' == '${expected_priority}'
#        ...    Set Variable    ${entry_found}    True
#        Run Keyword If    '${entry_found}' == 'True'    Exit For Loop
#    END
#
#    IF    ${entry_found}
#        Log    Entry with same Business Unit, Specialty and Priority already exists. Skipping creation.    WARN
#        RETURN
#    END

#    Wait Until Element Is Visible    ${MC_DETAIL_NEW_BUTTON_XPATH}    10s
#    Click Element    ${MC_DETAIL_NEW_BUTTON_XPATH}
#    Sleep    8s
#
#    Set Focus To Element    ${SEARCH_MC_DETAIL_BUSINESS_UNIT_DROWNDOWN_XPATH}
#    Input Text      ${SEARCH_MC_DETAIL_BUSINESS_UNIT_DROWNDOWN_XPATH}   ${BU_NAME}
#    Sleep    3s
#    Wait Until Element Is Visible   ${SEARCH_MC_DETAIL_BUSINESS_UNIT_DROWNDOWN_OPTIONS_XPATH}   10s
#    Click Element   ${SEARCH_MC_DETAIL_BUSINESS_UNIT_OPTION_XPATH}
#    Click Button    ${MC_DETAIL_FREQUENCY_DROPDOWN_XPATH}
#    Click Element   ${MC_DETAIL_FREQUENCY_OPTION_XPATH}
#    Click Button    ${MC_DETAIL_COUNTRY_DROPDOWN_XPATH}
#    Click Element   ${MC_DETAIL_COUNTRY_OPTION_XPATH}
#    Click Button    ${CONTACT_PRIORITY_DROPDOWN_XPATH}
#    Click Element   ${CONTACT_BU_PRIORITY_OPTION_XPATH}
#    Sleep    3s
#    Execute JavaScript    document.evaluate("//div[contains(text(),'Specialty')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView()
#    Sleep    3s
#    Set Focus To Element    ${MC_DETAIL_SPECIALTY_OPTION_XPATH}
#    Set Focus To Element    ${MC_DETAIL_MOVE_TO_BUTTON_XPATH}
#    Click Element    ${MC_DETAIL_MOVE_TO_BUTTON_XPATH}
#    Click Element    ${SAVE_BUTTON_XPATH}


#*** Keywords ***
#Create Marketing Cycle Detail
#    Sleep    10s
##    Execute JavaScript    window.scrollBy(0, 600);
##    Execute JavaScript    document.evaluate("//span[contains(text(),'Marketing Cycle Detail')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView
#    Execute JavaScript    document.evaluate("//li[@data-target-selection-name='sfdc:StandardButton.MarketingCycleDetail__c.New']//button[text()='New']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView({ behavior: 'smooth', block: 'center' });
#    Sleep    5s
#    Wait Until Element Is Visible    ${MC_DETAIL_NEW_BUTTON_XPATH}    10s
#    Click Element    ${MC_DETAIL_NEW_BUTTON_XPATH}
#    Sleep    10s
##    Wait Until Element Is Visible    ${NEW_MC_DETAIL_PAGE}  10s
#    Set Focus To Element    ${SEARCH_MC_DETAIL_BUSINESS_UNIT_DROWNDOWN_XPATH}
#    Input Text      ${SEARCH_MC_DETAIL_BUSINESS_UNIT_DROWNDOWN_XPATH}   ${BU_NAME}
#    Sleep    5s
#    Wait Until Element Is Visible   ${SEARCH_MC_DETAIL_BUSINESS_UNIT_DROWNDOWN_OPTIONS_XPATH}   10s
#    Click Element   ${SEARCH_MC_DETAIL_BUSINESS_UNIT_OPTION_XPATH}
#    Click Button    ${MC_DETAIL_FREQUENCY_DROPDOWN_XPATH}
#    Click Element   ${MC_DETAIL_FREQUENCY_OPTION_XPATH}
#    Click Button    ${MC_DETAIL_COUNTRY_DROPDOWN_XPATH}
#    Click Element   ${MC_DETAIL_COUNTRY_OPTION_XPATH}
#    Click Button    ${CONTACT_PRIORITY_DROPDOWN_XPATH}
#    Click Element   ${CONTACT_BU_PRIORITY_OPTION_XPATH}
#    Sleep    5s
#    Execute JavaScript    document.evaluate("//div[contains(text(),'Specialty')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView()
#    Sleep    5s
#    Set Focus To Element    ${MC_DETAIL_SPECIALTY_OPTION_XPATH}
#    Set Focus To Element    ${MC_DETAIL_MOVE_TO_BUTTON_XPATH}
#    Click Element    ${MC_DETAIL_MOVE_TO_BUTTON_XPATH}
#    Click Element    ${SAVE_BUTTON_XPATH}



