*** Settings ***
Library     SeleniumLibrary
Resource    ../Marketing_Cycle_Folder/Marketing_Cycle.resource
Resource    ../Contact_Business_Unit_Folder/Contact_Business_Unit.resource
Library     ../Marketing_Cycle_Detail_Folder/scroll_keyword.py


*** Variables ***
# Create Marketing Cycle Detail XPath
${MC_DETAIL_NEW_BUTTON_XPATH}   xpath=//li[@data-target-selection-name='sfdc:StandardButton.MarketingCycleDetail__c.New']//button[contains(.,'New')]
${NEW_MC_DETAIL_PAGE}  New Marketing Cycle Detail
${SEARCH_MC_DETAIL_BUSINESS_UNIT_DROWNDOWN_XPATH}   xpath=//div[@data-target-selection-name='sfdc:RecordField.MarketingCycleDetail__c.Business_Unit__c']//input[contains(@placeholder,'Business Unit')]
${SEARCH_MC_DETAIL_BUSINESS_UNIT_DROWNDOWN_OPTIONS_XPATH}     xpath=//div[@data-target-selection-name="sfdc:RecordField.MarketingCycleDetail__c.Business_Unit__c"]//lightning-base-combobox-item[@class='slds-media slds-listbox__option slds-media_center slds-listbox__option_entity' and @role='option']
${SEARCH_MC_DETAIL_BUSINESS_UNIT_OPTION_XPATH}      xpath=(//div[@data-target-selection-name="sfdc:RecordField.MarketingCycleDetail__c.Business_Unit__c"]//lightning-base-combobox-item[@class='slds-media slds-listbox__option slds-media_center slds-listbox__option_entity' and @role='option'])[2]
${MC_DETAIL_COUNTRY_DROPDOWN_XPATH}     xpath=//div[@data-target-selection-name='sfdc:RecordField.MarketingCycleDetail__c.Country__c']//button[@aria-label='Country']
${MC_DETAIL_COUNTRY_OPTION_XPATH}     xpath=//div[@data-target-selection-name='sfdc:RecordField.MarketingCycleDetail__c.Country__c']//lightning-base-combobox-item[@role='option' and @data-value='United Arab Emirates']


${MC_DETAIL_FREQUENCY_DROPDOWN_XPATH}  xpath=//button[@aria-label='Frequency']
${MC_DETAIL_FREQUENCY_OPTION_XPATH}     xpath=//lightning-base-combobox-item[@data-value='2']
${MC_DETAIL_SPECIALTY_OPTION_XPATH}     xpath=//div[@data-value='ENT']
${MC_DETAIL_MOVE_TO_BUTTON_XPATH}     xpath=//button[@title='Move to Chosen']//lightning-primitive-icon[@variant='bare']

*** Keywords ***
Create Marketing Cycle Detail
    Sleep    10s
    Execute JavaScript    window.scrollBy(0, 500);
    Wait Until Element Is Visible    ${MC_DETAIL_NEW_BUTTON_XPATH}    10s
    Click Element    ${MC_DETAIL_NEW_BUTTON_XPATH}
    Sleep    10s
#    Wait Until Element Is Visible    ${NEW_MC_DETAIL_PAGE}  10s
    Set Focus To Element    ${SEARCH_MC_DETAIL_BUSINESS_UNIT_DROWNDOWN_XPATH}
    Input Text      ${SEARCH_MC_DETAIL_BUSINESS_UNIT_DROWNDOWN_XPATH}   ${BU_NAME}
    Sleep    5s
    Wait Until Element Is Visible   ${SEARCH_MC_DETAIL_BUSINESS_UNIT_DROWNDOWN_OPTIONS_XPATH}   10s
    Click Element   ${SEARCH_MC_DETAIL_BUSINESS_UNIT_OPTION_XPATH}
    Click Button    ${MC_DETAIL_FREQUENCY_DROPDOWN_XPATH}
    Click Element   ${MC_DETAIL_FREQUENCY_OPTION_XPATH}
    Click Button    ${MC_DETAIL_COUNTRY_DROPDOWN_XPATH}
    Click Element   ${MC_DETAIL_COUNTRY_OPTION_XPATH}
    Click Button    ${CONTACT_PRIORITY_DROPDOWN_XPATH}
    Click Element   ${CONTACT_BU_PRIORITY_OPTION_XPATH}
    Sleep    5s
    Execute JavaScript    document.evaluate("//div[contains(text(),'Specialty')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView()
    Sleep    5s
    Set Focus To Element    ${MC_DETAIL_SPECIALTY_OPTION_XPATH}
    Set Focus To Element    ${MC_DETAIL_MOVE_TO_BUTTON_XPATH}
    Click Element    ${MC_DETAIL_MOVE_TO_BUTTON_XPATH}
    Click Element    ${SAVE_BUTTON_XPATH}



