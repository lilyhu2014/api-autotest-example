*** Settings ***
Resource   ..${/}..${/}..${/}..${/}..${/}config${/}runtime.robot
Resource   ..${/}..${/}..${/}..${/}..${/}keywords${/}common.robot

Test Template   Greeting

*** Test Cases ***                   expected_status_code       name      
Greeting without query name               200                  ${empty}                
Greeting with query name                  200                  Lily   
    
*** Keywords ***
Greeting
    [Arguments]   ${expected_status_code}    ${name}
    ${base_greeting_url}=  setVariable  ${BASE_API_URL}/greeting
    ${query_params}=  Initialize Params   ${name}
    ${greeting_url} =  Set Variable  ${base_greeting_url}${query_params}
    ${result} =  Invoke Service  GET  ${empty}  ${greeting_url}
    Should Be Equal As Integers   ${result.statusCode}    ${expected_status_code}
    Run Keyword If  ${expected_status_code} == 200   Validate 200 Response Body  ${name}  ${result.response}     
 
Initialize Params
    [Arguments]    ${name}
    ${params}=   Run Keyword If  "${name}" == "${empty}"  Set Variable  ${empty}
    ...    ELSE  Set Variable  ?name=Lily  
    [Return]   ${params}
    
Validate 200 Response Body
    [Arguments]  ${name}   ${response}
    ${content}=  Set Variable If  "${name}" == "${empty}"    World     ${name}
    
    ${expected_response_template} =  Catenate  $.content REPLACE WITH "Hello, ${content}!";
    
    ${expected_response} =  Build Json Template   ${CURDIR}/getGreeting.response  ${expected_response_template}
    Validate Json Object  ${expected_response}   ${response}
