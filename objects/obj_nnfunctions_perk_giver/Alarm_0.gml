if (array_length(queue) == 0) {
	exit;
}

var _perk_data = array_pop(queue);
INTERNAL_give_perk(_perk_data.perk, _perk_data.x, _perk_data.y);

alarm_set(0, 10);