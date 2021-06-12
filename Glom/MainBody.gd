extends KinematicBody2D

var _collision_count = 0;
var _prev_col

func _ready():
	_prev_col = get_node($"..".prev_collider)

func _physics_process(_delta):
	if($"..".stuck):
		var dir = $"../Projectile".position-position
		move_and_slide(dir.normalized() * 500)
		if dir.length_squared() < 400 * $"..".size:
			$"..".new_player($"../Projectile", $"..".size)
			return
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision == _prev_col:
				_collision_count += 1
			if _collision_count >= 40:
				$"..".sever()
			_prev_col = collision
			return
		_collision_count = 0
