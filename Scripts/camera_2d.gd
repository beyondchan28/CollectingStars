extends Camera2D

const DEAD_ZONE := 0.2
@onready var defaul_pos := self.position

func _unhandled_input(event: InputEvent) -> void:
	if not MouseState.is_drag() and not MouseState.is_holding() and event is InputEventMouseMotion:
		var _target :Vector2 = event.position - get_viewport().size * 0.5
		if _target.length() < DEAD_ZONE:
			self.position = defaul_pos
		else:
			self.position = _target.normalized() * (_target.length() - DEAD_ZONE) * 0.5
