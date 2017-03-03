GRAPH="social-network-graph" # graph name with a time stamp
URL=https://ibmgraph-alpha.ng.bluemix.net/aeb7460c-8f97-42d6-9baa-5a96182db2db
TOKEN=NDQwMTIxYjgtNWJjOS00ZmFiLTg1NzMtYzk5N2FhNmFjN2FmOjE0ODc3NTQyOTg4ODQ6RlN6aUl1bEJUWFgwRUtTMW51bzB3NENPTHd0eFJpa3c5eUtQU25wYWk2OD0=



cat << ENDGREMLIN >gremlin.json
{
  "gremlin": "graph.traversal().V().hasLabel('person').has('name', 'Alex').outE('updates').inV();"
}
ENDGREMLIN
curl "$URL/$GRAPH/gremlin" \
     -X 'POST' \
     -H "Authorization: gds-token $TOKEN" \
     -H 'Content-Type: application/json' \
     -d @gremlin.json | jq '.'
