extends Node2D

var _is_hold := true

func _ready() -> void:
	$RigidBody2D.sleeping = true
	$RigidBody2D.freeze = true

func _input(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_is_hold = false
		$RigidBody2D.sleeping = false
		$RigidBody2D.freeze = false
	if _is_hold:
		self.global_position = get_global_mouse_position()
