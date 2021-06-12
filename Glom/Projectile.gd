extends RigidBody2D

func _integrate_forces(state):
	if($"..".readied):
		return
	for i in range(state.get_contact_count()):
		var body = state.get_contact_collider_object(i)
		if body.is_in_group("sticky") and \
				not body == get_node($"..".prev_collider):
			set_deferred("mode", 3)
			$"..".stuck = true
			$"..".next_collider = body.get_path()
			
