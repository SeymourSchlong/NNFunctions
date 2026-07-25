queue = [];
alarm_set(0, 10);

function add_to_queue(perk_id) {
	array_push(queue, perk_id);
	
	if (alarm_get(0) == 0) {
		alarm_set(0, 10);
	}
}