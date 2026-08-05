queue = [];
alarm_set(0, 10);

function add_to_queue(perk) {
	array_push(queue, perk);
	
	if (alarm_get(0) == 0) {
		alarm_set(0, 10);
	}
}