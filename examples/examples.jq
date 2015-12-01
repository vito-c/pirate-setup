#map values
echo '[{"attrs":{"class":"foo"},"properties":{}},{"attrs":{"class":"bar"},"text":"20"},{"attrs":{"class":"zap"},"text":"thing"},{"attrs":{"class":"bar"},"text":"10"},{"attrs":{"class":"zap"},"text":"zip"}]' | 
	jq '{data : . , vals: map(select( .attrs.class == "bar").text ), names: map( select( .attrs.class == "zap").text )}'
#access at an index not really a good example
echo ' {"data": [["building_A","floor_2",[["chair","1.0"],["table","2.2"],["desk","1.2"]]], ["building_B","floor_1",[["chair","1.0"]]]]}' | 
	jq '.data[]|{"index": {"_id":.[0]}}, {"building": .[0], "floor": .[1],"contents":[.[2][]|{"object":.[0], "amount":.[1]}]}'
#reduce or merge arrays
echo '{"vals":["20","10"],"names":["thing","zip"]}' | 
	jq '.vals as $vals | .names as $names | reduce range(0; $names|length) as $i ([]; . + [{ "val": $vals[$i], "name": $names[$i] }])'
