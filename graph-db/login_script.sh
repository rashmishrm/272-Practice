
URL=https://ibmgraph-alpha.ng.bluemix.net/aeb7460c-8f97-42d6-9baa-5a96182db2db

TOKEN=$(curl "https://ibmgraph-alpha.ng.bluemix.net/aeb7460c-8f97-42d6-9baa-5a96182db2db/_session" -u "440121b8-5bc9-4fab-8573-c997aa6ac7af:b1a1405e-49f7-4680-82f3-fdfd206ede55" | jq -r '.["gds-token"]')
echo "Your session token is $TOKEN"


GRAPH="social-network-graph" # graph name with a time stamp

ECHO $GRAPH
curl "$URL/_graphs/$GRAPH" \
     -X POST \
     -H "Authorization: gds-token $TOKEN" \
     -d '' | jq '.'


     SCHEMA='
     {
       "propertyKeys": [
         {"name": "name", "dataType": "String", "cardinality": "SINGLE"},
         {"name": "status", "dataType": "String", "cardinality": "SINGLE"},
         {"name": "age", "dataType": "Integer", "cardinality": "SINGLE"},
         {"name": "location", "dataType": "String", "cardinality": "SINGLE"},
         {"name": "text", "dataType": "String", "cardinality": "SINGLE"},
         {"name": "tags", "dataType": "String", "cardinality": "SINGLE"},
         {"name": "file", "dataType": "String", "cardinality": "SINGLE"},
         {"name": "group_name", "dataType": "String", "cardinality": "SINGLE"},
         {"name": "group_desc", "dataType": "String", "cardinality": "SINGLE"},
         {"name": "status_time", "dataType": "String", "cardinality": "SINGLE"}
       ],
       "vertexLabels": [
         {"name": "person"},
         {"name": "photograph"},
         {"name": "post"},
         {"name": "group"}
       ],
       "edgeLabels": [
         {"name": "uploads", "multiplicity": "MULTI"},
         {"name": "updates", "multiplicity": "MULTI"},
         {"name": "joins", "multiplicity": "MULTI"},
         {"name": "likes", "multiplicity": "MULTI"},
         {"name": "connects", "multiplicity": "MULTI"}

       ],
       "vertexIndexes": [
         {"name": "vByName", "propertyKeys": ["name"], "composite": true, "unique": true},
         {"name": "vByAge", "propertyKeys": ["age"], "composite": true, "unique": false},
         {"name": "vByGroup", "propertyKeys": ["group_name"], "composite": true, "unique": false}
       ],
       "edgeIndexes" :[
         {"name": "eByStatusTime", "propertyKeys": ["status_time"], "composite": true, "unique": false}
       ]
     }'

     curl "$URL/$GRAPH/schema" \
          -X POST \
          -H "Authorization: gds-token $TOKEN" \
          -H 'Content-Type: application/json' \
          -d "$SCHEMA" | jq '.'
