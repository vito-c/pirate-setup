# TODO: create simple way to display starting objects and output
# echo '{ "a":[], "b":["one","two"], "e":["three"], "c":null, "d":null}' | jq '.c += .a | .c += .b | .c += .e | del( .a ) | del(.b)| del(.e) | if .d == null then del( .d ) else . end'
.c += .a | .c += .b | .c += .e | del( .a ) | del(.b)| del(.e) | if .d == null then del( .d ) else . end
