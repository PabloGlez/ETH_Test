*** Settings ***
Resource      ../keywords/curf.robot
Test Setup      Set CAN Bus ${INTERFACE} ${CHANNEL} ${BITRATE} ${DB FILE} ${APP NAME}
# Test Teardown   End Log Can 
Library    DateTime

*** Variables ***
${DB FILE}              ../dbc/test_dbc.dbc
${INTERFACE}            vector
${CHANNEL}              1
${BITRATE}              500000
${DEFAULT TIMEOUT}      5
${DEFAULT NODE}         DRIVER
${APP NAME}             robot

*** Test Cases ***

Check reception of a frame with given ID and any data
    Check The Frame Reception With ID 110 And ANY As Data Timeout ${DEFAULT TIMEOUT} Seconds

Check reception of a frame
    Check The Frame Reception With ID 110 And 0105 As Data Timeout ${10} Seconds

#Check reception of a frame
#    Check The Frame Reception With ID 110 And 010A As Data Timeout ${10} Seconds

