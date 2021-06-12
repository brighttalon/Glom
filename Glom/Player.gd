extends Node2D

export (NodePath) var prev_collider
export var size = 1.0
var next_collider
var readied = true
var stuck = false
var _player_scene

func _ready():
	if size < 0.3:
		queue_free()
	_player_scene = load("res://Player.tscn")
	next_collider = prev_collider
	

func _input(event):
	if event.is_action_pressed("ui_select") and readied:
		var impulse = (get_viewport().get_mouse_position() - position)
		if impulse.length_squared() > 14400:
			impulse = impulse.normalized() * 120
		impulse *= 5 * sqrt(size)
		$Projectile.apply_central_impulse(impulse)
		readied = false
	if event.is_action_released("ui_select") and not readied and not stuck:
		new_player(self, size) 

	
func new_player(body, new_size, free = true):
	var new_player = _player_scene.instance()
	new_player.position = body.global_position
	new_player.prev_collider = next_collider
	new_player.next_collider = next_collider
	new_player.size = new_size
	$"..".add_child(new_player)
	if free:
		queue_free()
		
		
func sever():
	new_player($Projectile, sqrt(0.5) * size, false)
	new_player($MainBody, sqrt(0.5) * size)
