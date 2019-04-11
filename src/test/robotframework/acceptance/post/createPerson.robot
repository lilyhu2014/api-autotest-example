*** Settings ***
Resource   ..${/}..${/}..${/}..${/}..${/}config${/}runtime.robot
Resource   ..${/}..${/}..${/}..${/}..${/}keywords${/}common.robot

Test Template   Create Person

*** Test Cases ***                   expected_status_code         firstName     lastName      
Create person without firstname               409                   null           Hu    
Create person without lastname                409                   Lily           null
Create person                                 201                   Lily           Hu

*** Keywords ***
Create Person     
    [Arguments]      ${expected_status_code}    ${firstName}   ${lastName}
    ${api_url}=  Set Variable   ${BASE_API_URL}/people
    
    ${firstName}=   Set Variable If  "${firstName}" == "null"   ${None}   "${firstName}"
    ${lastName}=   Set Variable If  "${lastName}" == "null"   ${None}   "${lastName}"
    
    ${request_body}=  Catenate  $.firstName REPLACE WITH ${firstName};
    ...    $.lastName REPLACE WITH ${lastName};
    
    ${payload}=   Build Json Template  ${CURDIR}/createPerson.request   ${request_body}
    
    ${request_headers}=   Create Dictionary
    ...    Content-Type=application/json
    
    ${result}=  Invoke Service   POST  ${request_headers}   ${api_url}  ${payload}
    
    Should Be Equal As Integers   ${result.statusCode}    ${expected_status_code}
    Run Keyword If  ${expected_status_code} == 200   Validate 200 Response Body  ${firstName}    ${lastName}  ${result.response} 
    
    
Validate 200 Response Body
    [Arguments]  ${firstName}    ${lastName}    ${response}
    ${expected_response_template} =  Catenate   $.firstName REPLACE WITH "${firstName}";
    ...    $.lastName REPLACE WITH "${lastName}";
    
    ${expected_response} =  Build Json Template   ${CURDIR}/createPerson.response  ${expected_response_template}
    Validate Json Object  ${expected_response}   ${response}