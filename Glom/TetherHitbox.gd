extends CollisionPolygon2D


func _physics_process(_delta):
	var player = $"../.."
	var main_body_pos = player.get_node("MainBody").position
	var projectile_pos = player.get_node("Projectile").position
	var normal = (main_body_pos - projectile_pos).normalized().tangent() \
			 * player.size
	polygon = PoolVector2Array(
		[main_body_pos + normal,
		projectile_pos + normal,
		projectile_pos - normal,
		main_body_pos - normal,
		])
