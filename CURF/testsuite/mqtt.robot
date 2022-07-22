*** Settings ***
Resource      ../keywords/MQTTLibrary/kewywords.robot

| *Variables*       | *Value*
| ${broker.uri}     | 127.0.0.1
| ${broker.port}    | 1883
| ${client.id}      | mqtt.test.client
| ${topic}          | ETH
| ${topic_rx}       | ETH_RX
| ${sub.topic}      | CAN/Network1/ECU1

*** Test Cases ****
# | Connect to FordSIM API broker 
# | | ${mqttc}    | Connect   | ${broker.uri} | client_id=${client.id}
# | | Should be equal as strings  | ${mqttc._client_id}   | ${client.id}
# | | [Teardown]  | Disconnect

# | Subscribe to topic
# | | ${mqttc}    | Connect   | ${broker.uri} | client_id=${client.id}
# | | ${mqttc}    | Subscribe | topic=${topic} | qos=0
# | | [Teardown]  | Disconnect

# # Receive expected value from ESUSIM
# | Validate expected value sent from ECUSIM
# | | ${mqttc}    | Connect   | ${broker.uri} | client_id=${client.id}
# | | ${mqttc}    | Subscribe and Validate | topic=${sub.topic} | qos=0 | payload=['0', '0', '0', '0', '0', '0', '0', '5'] | timeout=3

# | Send expected vaule to ECUSIM
# | | Publish Single | topic=${topic}    | payload= [272,[0, 0, 0, 0, 0, 0, 0, 6],1] | hostname=${broker.uri}

# # Receive expected value from ESUSIM
# | Validate reply from ECUSIM
# | | ${mqttc}    | Connect   | ${broker.uri} | client_id=${client.id}
# | | ${mqttc}    | Subscribe and Validate | topic=${sub.topic} | qos=0 | payload=['0', '0', '0', '0', '0', '0', '0', '6'] | timeout=8

| Send Ethernet Frame
| | ${mqttc}    | Connect   | ${broker.uri} | client_id=${client.id}
| | Send Ethernet Frame | ip_src=192.168.100.23 | ip_dst=192.168.100.27 | mac_src=64:5D:86:A1:0E:AF | mac_dst=AA:BB:CC:DD:EE:FF | udp_sport=30490 | udp_dport=30490 | payload=1 | topic=${topic}

| Verify Expected Frame
| | ${mqttc}    | Connect   | ${broker.uri} | client_id=${client.id}
| | ${mqttc}    | Subscribe | topic=${topic_rx} | qos=0
| | Verify Ethernet Frame   | topic=${topic_rx} | qos=0 | payload=2 | timeout=8

