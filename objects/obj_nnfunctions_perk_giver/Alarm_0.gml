if (array_length(queue) == 0) {
	exit;
}

var _perk_to_give = array_pop(queue);
INTERNAL_give_perk(_perk_to_give);

alarm_set(0, 10);