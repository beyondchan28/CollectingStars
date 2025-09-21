extends ScrollContainer

const _star_button := preload("res://Scenes/star_button.tscn")

@onready var _star_container: GridContainer = $StarContainer

func _stored_star() -> void:
	var _all_star_btn := _star_container.get_children()
	var _star := MouseState.get_holded_star()
	if _all_star_btn.size() == 0:
		_add_new_star_button(_star)
		_star.queue_free()
	else:
		for _btn: StarButton in _all_star_btn:
			if _btn.get_star_type() == _star.get_type():
				_btn.increase_star_amount()
				_star.queue_free()
				return
		_add_new_star_button(_star)
	

func _add_new_star_button(s: Star) -> void:
	var _new_star_button := _star_button.instantiate()
	_new_star_button.increase_star_amount()
	_new_star_button.set_star_type(s.get_type())
	_star_container.add_child(_new_star_button)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		# check if mouse is inside the inventory rectangle
		var _is_mouse_inside := self.get_global_rect().has_point(get_global_mouse_position())
		if _is_mouse_inside and MouseState.is_holding() and event.is_released():
			_stored_star()
			
