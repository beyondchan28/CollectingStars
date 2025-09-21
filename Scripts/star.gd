class_name Star extends RigidBody2D

const LAUNCH_POWER := 500.0

enum StarType {
	RED, GREEN, BLUE
}

@export var _type :StarType

func _ready() -> void:
	match _type:
		StarType.RED:
			$Display.color = Color.RED
		StarType.GREEN:
			$Display.color = Color.GREEN
		StarType.BLUE:
			$Display.color = Color.BLUE
	
	$PickArea.input_event.connect(_on_star_clicked)
	$PickArea.mouse_entered.connect(_on_star_mouse_entered)
	$PickArea.mouse_exited.connect(_on_star_mouse_exited)

# toggle the physics state, so its more performant and prevent unintented behavior
func freeze_physics(b: bool) -> void:
	self.sleeping = b
	self.freeze = b

# picking the star via PickArea (Area2D)
func _on_star_clicked(_viewport, event: InputEvent, _shape_idx) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			freeze_physics(true)
			MouseState.set_holded_star(self)

func _on_star_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property($Display, "scale", Vector2(1.3, 1.3), 0.2)

func _on_star_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property($Display, "scale", Vector2.ONE, 0.2)

func set_type(st: StarType) -> void:
	_type = st
func get_type() -> StarType:
	return _type

func launch() -> void:
	self.apply_impulse(Vector2.LEFT * LAUNCH_POWER) # launch projectile
	await get_tree().create_timer(0.3).timeout
	# cancel out the launch impulse after 0.3 secs
	# NOTE: reduce launch power a bit, so star moving a bit to the left
	self.apply_impulse(Vector2.RIGHT * (LAUNCH_POWER - 20.0)) 
