class_name Star extends RigidBody2D

func _ready() -> void:
	$PickArea.input_event.connect(_on_star_clicked)
	freeze_physics(true)

func freeze_physics(b: bool) -> void:
	self.sleeping = b
	self.freeze = b

func _on_star_clicked(_viewport, event: InputEvent, _shape_idx) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			freeze_physics(true)
			MouseState.set_holded_star(self)
