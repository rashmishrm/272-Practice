
GRAPH="social-network-graph" # graph name with a time stamp
URL=https://ibmgraph-alpha.ng.bluemix.net/aeb7460c-8f97-42d6-9baa-5a96182db2db
TOKEN=NDQwMTIxYjgtNWJjOS00ZmFiLTg1NzMtYzk5N2FhNmFjN2FmOjE0ODc3NTQyOTg4ODQ6RlN6aUl1bEJUWFgwRUtTMW51bzB3NENPTHd0eFJpa3c5eUtQU25wYWk2OD0=

cat << ENDGREMLIN >gremlin.json # write everything until ENDGREMLIN into gremlin.json
{
  "gremlin": "
  def alex =  graph.addVertex(T.label, 'person', 'name', 'Alex', 'status', 'Single','age',18);
  def john =  graph.addVertex(T.label, 'person', 'name', 'John', 'status', 'Single','age',38);
  def lisa =  graph.addVertex(T.label, 'person', 'name', 'Lisa', 'status', 'Married','age',28);

  def sjsu_group =  graph.addVertex(T.label, 'group', 'group_name', 'SjSU Group', 'group_desc', 'SJSU Group');


  def alexPost =  graph.addVertex(T.label, 'post', 'text', 'BlueMix is great!', 'tags', '#Bluemix, #Awesome','status_time','21/02/2017','file','None');
  def johnPost =  graph.addVertex(T.label, 'post', 'text', 'Apache Tinker', 'tags', '#Apache, #Awesome','status_time','21/02/2017','file','None');


  def lisaPhotograph =  graph.addVertex(T.label, 'photograph', 'location', 'San Francisco', 'file','abc.jpg');

  alex.addEdge('updates', alexPost);
  john.addEdge('updates', johnPost);

  alex.addEdge('connects', john);
  alex.addEdge('connects', lisa);
  john.addEdge('connects', lisa);

  lisa.addEdge('uploads', lisaPhotograph);
  john.addEdge('joins', sjsu_group);

  john.addEdge('likes', lisaPhotograph);
  alex.addEdge('likes', johnPost);
  "
}
ENDGREMLIN

curl "$URL/$GRAPH/gremlin" \
     -X POST \
     -H "Authorization: gds-token $TOKEN" \
     -H 'Content-Type: application/json' \
     -d @gremlin.json | jq '.'
