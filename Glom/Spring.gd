extends DampedSpringJoint2D

func _ready():
	stiffness *= 1/$"..".size
