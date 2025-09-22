class_name Description extends ColorRect

func _ready() -> void:
	self.hide()

func show_description(is_debug:bool, desc: String) -> void:
	self.global_position = get_global_mouse_position()
	if not is_debug:
		self.global_position.x -= self.size.x
	else:
		self.global_position.y -= self.size.y
	$DescriptionLabel.text = desc
	self.show()
