extends Node2D

# NOTE: This script is global

var _is_drag := false
var _holded_star: Star = null

func _unhandled_input(event: InputEvent) -> void:
	# chek mouse left button event
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		# check mouse event is pressed or release 
		if _is_drag == false and event.is_pressed():
			set_drag(true)
		elif _is_drag and event.is_released():
			set_drag(false)
			# if holding a star, activate physics and clear
			if is_holding():
				_holded_star.freeze_physics(false)
				_holded_star = null
			
	if _is_drag and is_holding() and event is InputEventMouseMotion:
		_holded_star.position = get_global_mouse_position()

func is_holding() -> bool:
	return _holded_star != null

# Happen when clicked a star
func set_holded_star(s: Star) -> void:
	_holded_star = s

func get_holded_star() -> Star:
	assert(is_holding(), "Currently not holding a star") # make sure to not returning null
	return _holded_star

func is_drag() -> bool:
	return _is_drag
func set_drag(b: bool) -> void:
	_is_drag = b
