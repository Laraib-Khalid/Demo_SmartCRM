*** Settings ***
Library     SeleniumLibrary
Resource    ../Contact_Business_Unit_Folder/Contact_Business_Unit.resource
Resource    ../Marketing_Cycle_Folder/Marketing_Cycle.resource

*** Variables ***
${CONTACT_TCL_NEW_BUTTON}  xpath=(//button[contains(.,'New')])[4]
${NEW_CONTACT_TCL_PAGE}  New Target Customer List
${CONTACT_PRIORITY_OPTION_XPATH}        B
#${SEARCH_CONTACT_TCL_DROWNDOWN_XPATH}  xpath=(//input[contains(@id,'combobox-input-')])[2]
#${SEARCH_CONTACT_TCL_TEXT}  US-ENT & Surgery
#${SEARCH_CONTACT_TCL_DROWNDOWN_OPTIONS_XPATH}     xpath=//lightning-base-combobox-item[@class='slds-media slds-listbox__option slds-media_center slds-listbox__option_entity' and @role='option']
#${SEARCH_CONTACT_TCL_DROWNDOWN_OPTIONS_XPATH}     xpath=//div[@data-target-selection-name="sfdc:RecordField.Target_Customer_List__c.Target__c"]//lightning-base-combobox-item[@class='slds-media slds-listbox__option slds-media_center slds-listbox__option_entity' and @role='option']
#${SEARCH_CONTACT_TCL_OPTION_XPATH}      xpath=(//lightning-base-combobox-item[@class='slds-media slds-listbox__option slds-media_center slds-listbox__option_entity' and @role='option'])[2]
${SEARCH_USER_DROPDOWN_XPATH}    xpath=//input[@placeholder='Search People...']
${SEARCH_USER_TEXT}     QA Team
${TCL_SEARCH_USER_DROPDOWN_OPTIONS_XPATH}   xpath=//div[@data-target-selection-name="sfdc:RecordField.Target_Customer_List__c.Target__c"]//lightning-base-combobox-item[@class='slds-media slds-listbox__option slds-media_center slds-listbox__option_entity' and @role='option']
${TCL_SEARCH_USER_OPTION_XPATH}     xpath=(//div[@data-target-selection-name="sfdc:RecordField.Target_Customer_List__c.Target__c"]//lightning-base-combobox-item[@class='slds-media slds-listbox__option slds-media_center slds-listbox__option_entity' and @role='option'])[2]
${TCL_ACTIVE_CHECKBOX_XPATH}    xpath=//div[@data-target-selection-name="sfdc:RecordField.Target_Customer_List__c.Active__c"]//input[@name='Active__c']
${TCL_APPROVAL_STATUS_DROPDOWN_XPATH}   xpath=//button[@aria-label='Approval Status']
${TCL_APPROVAL_STATUS_OPTION_XPATH}   xpath=//lightning-base-combobox-item[@role='option' and @data-value='Activated']
${TCL_CALCULATE_FREQUENCY_CHECKBOX_XPATH}   xpath=//input[@name='Calculate_Frequency_From_Cycle__c']
${TCL_MARKETING_CYCLE_DROPDOWN_XPATH}   xpath=//input[contains(@placeholder,'Search Marketing Cycle...')]
#${TCL_MARKETING_CYCLE_TEXT}     US-M
${TCL_MARKETING_CYCLE_OPTIONS_XPATH}     xpath=//div[@data-target-selection-name="sfdc:RecordField.Target_Customer_List__c.Marketing_Cycle__c"]//lightning-base-combobox-item[@class='slds-media slds-listbox__option slds-media_center slds-listbox__option_entity' and @role='option']
${TCL_MARKETING_CYCLE_OPTION_XPATH}      xpath=(//div[@data-target-selection-name="sfdc:RecordField.Target_Customer_List__c.Marketing_Cycle__c"]//lightning-base-combobox-item[@class='slds-media slds-listbox__option slds-media_center slds-listbox__option_entity' and @role='option'])[2]
${TCL_COUNTRY_DROPDOWN_XPATH}     xpath=//div[@data-target-selection-name="sfdc:RecordField.Target_Customer_List__c.Country__c"]//button[@aria-label='Country']
${TCL_COUNTRY_OPTION_XPATH}     xpath=//div[@data-target-selection-name="sfdc:RecordField.Target_Customer_List__c.Country__c"]//lightning-base-combobox-item[@role='option' and @data-value='United States']

${EDIT_ACTION_CONTACT_TCL_XPATH}  xpath=(//article[@aria-label='Target Customer List']//button[@class='slds-button slds-button_icon-border slds-button_icon-x-small'])[1]
#${EDIT_ACTION_CONTACT_TCL_XPATH}    xpath=//*[@id="tab-2"]/slot/flexipage-component2[5]/slot/lst-dynamic-related-list/article/laf-progressive-container/slot/lst-dynamic-related-list-with-user-prefs/lst-related-list-view-manager/lst-common-list-internal/div/div/lst-primary-display-manager/div/lst-primary-display/lst-primary-display-grid/lightning-datatable/div[2]/div/div/table/tbody/tr/td[7]/lightning-primitive-cell-factory/span/div/lightning-primitive-custom-cell/lst-list-view-row-level-action/lightning-button-menu/button
${DELETE_ACTION_CONTACT_TCL_XPATH}   xpath=//a[@class='slds-button slds-button--icon-x-small slds-button--icon-border-filled' and @title='Show 2 more actions']


*** Keywords ***
Create Contact TCL
    Sleep    5s
    Click on Contact Related Tab
    Execute JavaScript    window.scrollBy(0, 500);
    Sleep    10s
    Click Element    ${CONTACT_TCL_NEW_BUTTON}
    Wait Until Page Contains    ${NEW_CONTACT_TCL_PAGE}     10s
    Click Button    ${NEXT_BUTTON_XPATH}
    Sleep    5s
    Input Text     ${SEARCH_USER_DROPDOWN_XPATH}   ${SEARCH_USER_TEXT}
    Wait Until Element Is Visible    ${TCL_SEARCH_USER_DROPDOWN_OPTIONS_XPATH}  10s
    Click Element    ${TCL_SEARCH_USER_OPTION_XPATH}
    Click Button    ${CONTACT_PRIORITY_DROPDOWN_XPATH}
    Click Element   ${CONTACT_PRIORITY_OPTION_XPATH}
    Select Checkbox    ${TCL_ACTIVE_CHECKBOX_XPATH}
    Click Button    ${TCL_APPROVAL_STATUS_DROPDOWN_XPATH}
    Click Element    ${TCL_APPROVAL_STATUS_OPTION_XPATH}
    Select Checkbox    ${TCL_CALCULATE_FREQUENCY_CHECKBOX_XPATH}
    Input Text     ${TCL_MARKETING_CYCLE_DROPDOWN_XPATH}   ${MC_NAME}
    Wait Until Element Is Visible  ${TCL_MARKETING_CYCLE_OPTIONS_XPATH}      10s
    Sleep    5s
    Click Element    ${TCL_MARKETING_CYCLE_OPTION_XPATH}
    Set Focus To Element     ${TCL_COUNTRY_DROPDOWN_XPATH}
    Click Button    ${TCL_COUNTRY_DROPDOWN_XPATH}
    Click Element   ${TCL_COUNTRY_OPTION_XPATH}
    Click Button    ${SAVE_BUTTON_XPATH}