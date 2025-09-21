extends Node2D

var _is_holding := false
var _holded_star: Star = null

func _unhandled_input(event: InputEvent) -> void:
	# chek mouse left button event
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		# check mouse event is pressed or release 
		if _is_holding == false and event.is_pressed():
			_is_holding = true
		elif _is_holding and event.is_released():
			_is_holding = false
		# if holding a star, activate physics and clear
			if _holded_star != null:
				_holded_star.freeze_physics(false)
				_holded_star = null
			
	if _holded_star != null and event is InputEventMouseMotion:
		_holded_star.position = get_global_mouse_position()

func is_holding() -> bool:
	return _is_holding

# Happen when clicked a star
func set_holded_star(s: Star) -> void:
	_holded_star = s
