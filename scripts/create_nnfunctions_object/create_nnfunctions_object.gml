// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function create_nnfunctions_object(){
	global.nnfunctions = fixup({
		get_random_peg : get_random_peg,
		get_highest_peg : get_highest_peg,
		get_lowest_peg : get_lowest_peg,
		random_chance : random_chance,
		give_perk : give_perk,
		give_suspicious_key : give_suspicious_key,
		give_coins : give_coins,
		forgery_get_item_id : forgery_get_item_id,
		forgery_get_item_object : forgery_get_item_object,
		forgery_get_perk_id : forgery_get_perk_id,
		forgery_get_perk_object : forgery_get_perk_object,
		forgery_get_supervisor_id : forgery_get_supervisor_id,
		forgery_get_challenge_id : forgery_get_challenge_id,
		is_supervisor : is_supervisor,
		is_challenge : is_challenge
	});
}

function fixup(struct) {
	var arr = struct_get_names(struct)
	for (var i = 0; i < array_length(arr); i++) {
		var variable_name = arr[i];
		var value = struct[$ variable_name]
		if typeof(value) == "struct"
			struct[$ variable_name] = fixup(value)
		if typeof(value) == "ref" && is_callable(value) && !is_method(value)
			struct[$ variable_name] = method(undefined, value)
	}
	return struct
}