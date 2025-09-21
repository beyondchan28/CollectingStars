class_name StarButton extends TextureButton

@onready var _stars_parent: Node2D = $"../../../../StarsParent"

@export var _star_amount := 1 # how many star this button contain
@export var _star_type := Star.StarType.RED

const _star := preload("res://Scenes/star.tscn")

func _ready() -> void:
	_set_label()
	$AmountLabel.text = str(_star_amount)
	self.pressed.connect(_on_pressed)
	
func _on_pressed() -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var _new_star :Star = _star.instantiate()
		_new_star.set_type(_star_type)
		# make the mouse state to dragging and holding star
		_new_star.freeze_physics(false)
		MouseState.set_drag(true)
		MouseState.set_holded_star(_new_star)
		_new_star.global_position = get_global_mouse_position()
		# ------------------------------------------------------
		_stars_parent.add_child(_new_star)
		decrease_star_amount()
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		var _new_star :Star = _star.instantiate()
		_new_star.set_type(_star_type)
		_new_star.global_position = self.global_position + self.size/2.0 # launch from the middle of the button
		_stars_parent.add_child(_new_star)
		_new_star.launch() # launch star
		decrease_star_amount()
		

func _set_label() -> void :
	match _star_type:
		Star.StarType.RED:
			$TypeLabel.text = "RED"
		Star.StarType.GREEN:
			$TypeLabel.text = "GREEN"
		Star.StarType.BLUE:
			$TypeLabel.text = "BLUE"

func increase_star_amount() -> void:
	_star_amount += 1
	$AmountLabel.text = str(_star_amount)

func decrease_star_amount() -> void:
	_star_amount -= 1
	$AmountLabel.text = str(_star_amount)
	if _star_amount == 0:
		self.queue_free()

func set_star_type(s: Star.StarType) -> void:
	_star_type = s

func get_star_type() -> Star.StarType:
	return _star_type
